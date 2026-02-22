{ config, pkgs, ... }:
{
	home.username = "caspergamingone";
	home.homeDirectory = "/home/caspergamingone";
	programs.git.enable = true;
	
	home.stateVersion = "25.11";	

}
