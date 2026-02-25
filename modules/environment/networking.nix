{ config, pkgs, ... }:
{

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.hostName = "CasperGamingOne-precision7720"; # Define your hostname.
    networking.networkmanager.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 42420 ];
    networking.firewall.allowedUDPPorts = [ 42420 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

}
