{
  description = "4Everyone NixOS";

  inputs = {
	nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	nur = {
		url = "github:nix-community/NUR";
		inputs.nixpkgs.follows = "nixpkgs";
    };
	home-manager = {
		url = "github:nix-community/home-manager/release-25.11";
		inputs.nixpkgs.follows = "nixpkgs";
    };
	auto-cpufreq = {
		url = "github:AdnanHodzic/auto-cpufreq";
		inputs.nixpkgs.follows = "nixpkgs";
	};
    scopebuddy = {
		url = "github:HikariKnight/ScopeBuddy";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nur, auto-cpufreq, scopebuddy, flatpaks, ... } @inputs:
  let
	system = "x86_64-linux";
  in {
    nixosConfigurations.CasperGamingOne-precision7720 = nixpkgs.lib.nixosSystem {
		inherit system;
		specialArgs = { inherit inputs; };
				
		modules = [

			({
			nixpkgs.overlays = [
				(final: prev: {
					stable = import nixpkgs {
						inherit system;
						config = {
							allowUnfree = true;
							permittedInsecurePackages = [
								"ventoy-qt5-1.1.05"
							];
						};
					};

					unstable = import nixpkgs-unstable {
						inherit system;
						config = {
							allowUnfree = true;
							permittedInsecurePackages = [
								"ventoy-qt5-1.1.05"
							];
						};
					};
				}) ];
			})

			./configuration.nix

			nur.modules.nixos.default

			flatpaks.nixosModules.nix-flatpak

			home-manager.nixosModules.home-manager {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					extraSpecialArgs = {
						inherit inputs;
						flake-inputs = inputs;
					};
					users.caspergamingone = ./modules/home-manager; # replace <USERNAME> with your actual username
				};
			}

		];
	};
  };

}
