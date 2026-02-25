{ config, lib, pkgs, ... }:
{

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
            nur.repos.forkprince.proton-dw-bin
        ];
        protontricks.enable = true;
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
            "steam-run"
    ];

}
