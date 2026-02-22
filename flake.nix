{
  description = "4Everyone NixOS";

  inputs = {
	nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
    nixosConfigurations.CasperGamingOne-precision7720 = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		
		modules = [ 
			
			home-manager.nixosModules.default {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					users.caspergamingone = ./home.nix;
					backupFileExtension = "backup";
				};
			}		
			
			./configuration.nix 
		];			
	};
  };

}
