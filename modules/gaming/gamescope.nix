{ config, pkgs, ... }:
{

    programs.gamescope = {
        enable = true;
        package = pkgs.unstable.gamescope;
        capSysNice = true;
    };

    environment.systemPackages = with pkgs.unstable; [ gamescope-wsi ];

}
