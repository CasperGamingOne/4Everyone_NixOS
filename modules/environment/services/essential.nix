{ config, pkgs, ... }:
{
    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput = {
        enable = true;

        # disabling mouse acceleration
        mouse = {
            accelProfile = "flat";
        };
    };

    # Schedulers and Gaming services
    services.scx = {
        enable = true;
        package = pkgs.scx.rustscheds;
        scheduler = "scx_lavd";
        extraArgs = [
            "--performance"
        ];
    };
    services.zram-generator.enable = true;

    # Power Management
    services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "halt";
        HandleLidSwitchDocked = "ignore";
    };
    services.power-profiles-daemon.enable = false;
    services.tuned = {
        enable = true;
        settings = {
            daemon = true;
            dynamic_tuning = true;
        };
        ppdSupport = true;
        ppdSettings = {
            profiles = {
                balanced = "balanced";
                performance = "latency-performance";
                power-saver = "laptop-ac-powersave";
            };
            battery = {
                balanced = "balanced-battery";
                power-saver = "laptop-battery-powersave";
            };
        };
    };

    # Fixing Thermal Throttle Intel
    services.throttled = {
        enable = true;
        extraConfig = "
            [GENERAL]
            # Enable or disable the script execution
            Enabled: True
            # SYSFS path for checking if the system is running on AC power
            Sysfs_Power_Path: /sys/class/power_supply/AC*/online
            # Auto reload config on changes
            Autoreload: True

            ## Settings to apply while connected to Battery power
            [BATTERY]
            # Update the registers every this many seconds
            Update_Rate_s: 30
            # Max package power for time window #1
            PL1_Tdp_W: 20
            # Time window #1 duration
            PL1_Duration_s: 30
            # Max package power for time window #2
            PL2_Tdp_W: 30
            # Time window #2 duration
            PL2_Duration_S: 0.002
            # Max allowed temperature before throttling
            Trip_Temp_C: 80
            # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
            cTDP: 1
            # Disable BDPROCHOT (EXPERIMENTAL)
            Disable_BDPROCHOT: False

            ## Settings to apply while connected to AC power
            [AC]
            # Update the registers every this many seconds
            Update_Rate_s: 5
            # Max package power for time window #1
            PL1_Tdp_W: 40
            # Time window #1 duration
            PL1_Duration_s: 20
            # Max package power for time window #2
            PL2_Tdp_W: 45
            # Time window #2 duration
            PL2_Duration_S: 0.002
            # Max allowed temperature before throttling
            Trip_Temp_C: 94
            # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
            # Uncomment only if you really want to use it
            HWP_Mode: True
            # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
            cTDP: 1
            # Disable BDPROCHOT (EXPERIMENTAL)
            Disable_BDPROCHOT: False
        ";
    };

    # disable pulseaudio + extra stuff for audio to work perfectly
    services.pulseaudio.enable = false;

    security.rtkit.enable = true;

    hardware.alsa.enablePersistence = true;
    
    # Enable sound with pipewire + extra ton of shit
    services.pipewire = {
        enable = true;
        package = pkgs.pipewire;
        audio.enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
        
        extraConfig.pipewire."92-low-latency" = {
            "context.properties" = {
                "default.clock.allowed-rates" = "[ 44100, 48000 ]";
                "default.clock.quantum" = 1024;
                "default.clock.min-quantum" = 512;
                "default.clock.max-quantum" = 2048;
            };
        };
        
        extraConfig.pipewire-pulse."92-low-latency" = {
            context.modules = [{
                name = "libpipewire-module-protocol-pulse";
                args = {
                    "pulse.min.req" = "1024/48000";
                    "pulse.default.req" = "1024/48000";
                    "pulse.max.req" = "1024/48000";
                    "pulse.min.quantum" = "512/48000";
                    "pulse.max.quantum" = "2048/48000";
                };
            }];
            stream.properties = {
                "node.latency" = "512/48000";
                "resample.quality" = 1;
            };
        };

        wireplumber = {
            configPackages = [
                (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
                    monitor.bluez.properties = {
                        "bluez5.enable-sbc-xq" = true;
                        "bluez5.enable-msbc" = true;
                        "bluez5.enable-hw-volume" = true;
                        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
                    }''
                )
            ];
            extraConfig = {
                "11-bluetooth-policy" = {
                    "wireplumber.settings" = {
                        "bluetooth.autoswitch-to-headset-profile" = false;
                    };
                };
                "99-disable-suspend" = {
                    "monitor.alsa.rules" = [{
                        matches = [
                        {
                            "node.name" = "~alsa_input.*";
                        }
                        {
                            "node.name" = "~alsa_output.*";
                        }
                        ];
                        actions = {
                            update-props = {
                                "session.suspend-timeout-seconds" = 0;
                            };
                        };
                    }];
                };
            };
        };
    };

    # Bluetooth Headphones media control
    systemd.user.services.mpris-proxy = {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };


}
