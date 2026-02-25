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
        scheduler = "scx_lavd";
        package = pkgs.scx.rustscheds;
    };
    services.zram-generator.enable = true;

    # Power Management
    services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "halt";
        HandleLidSwitchDocked = "ignore";
    };
    services.power-profiles-daemon.enable = false;
    services.auto-cpufreq.enable = true;
    /* auto-cpufreq Flake
    programs.auto-cpufreq = {
        enable = true;
        settings = {
            charger = {
            governor = "performance";
            turbo = "auto";
            };

            battery = {
            governor = "powersave";
            turbo = "auto";
            };
        };
    };
    */
    # Intel thermald service ( fixing power throttling )
    services.thermald.enable = true;

    # Enable sound with pipewire.
    services.pipewire = {
        enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        wireplumber = {
            configPackages = [
                (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
                    monitor.bluez.properties = {
                    bluez5.enable-sbc-xq = true
                    bluez5.enable-msbc = true
                    bluez5.enable-hw-volume = true
                    bluez5.roles = [ a2dp_sink a2dp_source ]
                }'')
            ];
            extraConfig."11-bluetooth-policy" = {
                "wireplumber.settings" = {
                    "bluetooth.autoswitch-to-headset-profile" = false;
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
