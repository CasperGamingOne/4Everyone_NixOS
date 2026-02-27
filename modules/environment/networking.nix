{ config, pkgs, ... }:
{

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking = {
        hostName = "CasperGamingOne-precision7720"; # Define your hostname.
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
        };
        firewall = rec {
            allowedTCPPorts = [ 42420 ];
            allowedTCPPortRanges = [ { from = 1714; to = 1764; }  ];
            allowedUDPPorts = allowedTCPPorts;
            allowedUDPPortRanges = allowedTCPPortRanges;
        };
    };

}
