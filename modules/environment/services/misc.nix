{ config, pkgs, ... }:
{
    systemd.user.services.gpu-screen-recorder-ui.wantedBy = [ "default.target" ];

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Disk Management Service
    services.udisks2 = {
        enable = true;
        mountOnMedia = true;
    };

    # Flatpak Service
    services.flatpak = {
        enable = true;
        remotes = [
        {
            name = "Flathub";
            location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
        {
            name = "VintageStory";
            location = "https://flatpak.vintagestory.at/VintageStory.flatpakrepo";
        }
        ];
        uninstallUnmanaged = true;
        update.onActivation = true;
    };

    # ClamAV service
    services.clamav = {
        clamonacc.enable = true;
        daemon = {
            enable = true;
            settings = {
                OnAccessPrevention = true;
                OnAccessIncludePath = "/home/caspergamingone/Downloads";
            };
        };
        fangfrisch = {
            enable = true;
            interval = "daily";
        };
        package = pkgs.clamav;
        updater = {
            enable = true;
            frequency = 2;
            interval = "daily";
        };
    };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

}
