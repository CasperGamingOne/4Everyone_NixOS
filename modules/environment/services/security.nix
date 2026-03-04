{ config, pkgs, ... }:
{

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

    # AppArmor
    security.apparmor.enable = true;

    services.dbus.apparmor = "enabled";

}
