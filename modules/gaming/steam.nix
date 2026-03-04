{ config, lib, pkgs, ... }:
{

    programs.steam = {
        enable = true;
        package = pkgs.millennium-steam.override {
            extraLibraries = pkgs: [ pkgs.libxcb ];
            extraPkgs = pkgs: with pkgs; [
                libxcursor
                libxi
                libxinerama
                libxscrnsaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
        extest.enable = false; # translate X11 input events to uinput events (buggy)
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        extraPackages = with pkgs.unstable; [
            gamescope
            gamescope-wsi
        ];
        extraCompatPackages = with pkgs; [
            unstable.proton-ge-bin
            nur.repos.forkprince.proton-dw-bin
            nur.repos.forkprince.proton-cachyos-v3-bin
        ];
        protontricks = {
            enable = true;
            package = pkgs.unstable.protontricks;
        };
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
    ];

    programs.gamescope = {
        enable = true;
        package = pkgs.unstable.gamescope;
        capSysNice = false;
    };

    environment.systemPackages = with pkgs; [
        unstable.steam-run
        unstable.gamescope-wsi
    ];

}
