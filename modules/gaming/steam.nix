{ config, lib, pkgs, ... }:
{

    programs.steam = {
        enable = true;
        package = pkgs.steam.override {
            extraPkgs = pkgs': with pkgs'; [
                libxcursor
                libxi
                libxinerama
                libxscrnsaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib # Provides libstdc++.so.6
                libkrb5
                keyutils
                # Add other libraries as needed
            ];
        };
        extest.enable = false; # translate X11 input events to uinput events (buggy)
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        extraCompatPackages = with pkgs; [
            proton-ge-bin
            nur.repos.forkprince.proton-dw-bin
            nur.repos.forkprince.proton-cachyos-v2-bin
        ];
        protontricks.enable = true;
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
            "steam-run"
    ];

}
