{ config, pkgs, ... }:
{

    imports = [
        ./home.nix
        ./macchina
        ./browser.nix
        ./packages.nix
        ./flatpak.nix
        ./gaming-tricks
    ];

}
