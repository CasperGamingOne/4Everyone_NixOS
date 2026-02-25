{ config, pkgs, ... }:
{

    programs.gamescope = {
        enable = true;
        package = pkgs.unstable.gamescope;
        capSysNice = false;
    };

}
