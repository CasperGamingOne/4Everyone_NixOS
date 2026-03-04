{ config, pkgs, ... }:

{

    imports = [
        ./display.nix
        ./essential.nix
        ./security.nix
        ./misc.nix
    ];

}
