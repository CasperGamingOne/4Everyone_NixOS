{ config, pkgs, ... }:
{

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.caspergamingone = {
      isNormalUser = true;
      description = "CasperGamingOne";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
      packages = with pkgs; [

      ];
    };

}
