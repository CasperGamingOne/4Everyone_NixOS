{ config, pkgs, ... }:
{

    imports = [
        ./networking.nix
        ./services
        ./users.nix
        ./packages.nix
        ./scrap.nix
    ];

}
