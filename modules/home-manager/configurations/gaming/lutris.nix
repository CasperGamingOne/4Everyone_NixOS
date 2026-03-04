{ config, pkgs, ... }:
{

    programs.lutris = {
        enable = true;
        package = pkgs.unstable.lutris;
        protonPackages = with pkgs; [
            unstable.proton-ge-bin
        ];
    };

}
