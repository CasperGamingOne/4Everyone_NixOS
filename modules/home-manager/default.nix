{ config, pkgs, ... }:
{

    imports = [
        ./home.nix
        ./configurations
        ./packages.nix
        ./flatpak.nix
    ];

}
