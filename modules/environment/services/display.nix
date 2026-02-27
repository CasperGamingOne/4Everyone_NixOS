{ config, lib, pkgs, ... }:
{
    # Enable the X11 windowing system + necessary stuff for intel, nvidia and displaylink
    services.xserver = {
        enable = false;
       
        # Configure keymap in X11
        xkb = {
            layout = "us";
            variant = "";
        };

        desktopManager.xterm.enable = false;
        exportConfiguration = true;
        
        videoDrivers = [
            "displaylink"
            "modesetting"
            "nvidia"
        ];
    };

    # --- THIS IS THE CRUCIAL PART FOR ENABLING DISPLAYLINK ---
    systemd.services.displaylink-server = {
        enable = true;
        requires = [ "systemd-udevd.service" ];
        after = [ "systemd-udevd.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
            User = "root";
            Group = "root";
            Restart = "on-failure";
            RestartSec = 2; # Wait 2 seconds before restarting
        };
    };
    
    # Services systemd for suspend/resume/hibernate
    systemd.services = {
        nvidia-suspend.enable = true;
        nvidia-resume.enable = true;
        nvidia-hibernate.enable = true;
    };

    # KDE Plasma Desktop Environment
    services.displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
            autoNumlock = true;
            settings.General.DisplayServer = "wayland";
        };
        defaultSession = "plasma";
    };
    services.desktopManager.plasma6.enable = true;

}
