{
	description = "4Everyone NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, nix-cachyos-kernel, nur, home-manager, flatpaks, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
	in {
		nixosConfigurations.CasperGamingOne-precision7720 = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };

			modules = [

				({
				nixpkgs.overlays = [

					nix-cachyos-kernel.overlays.pinned

					(final: prev: {
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
						};
						users.caspergamingone = ./modules/home-manager; # replace <USERNAME> with your actual username
					};
				}

			];
		};

		devShells.${system}.default = pkgs.mkShell {
			buildInputs = with pkgs; [
				micromamba
				(python3.withPackages (ps: with ps; [
					jupyterlab
					jupyterlab-execute-time
					jupyterlab-widgets
					jupyterlab-git
					ipykernel
					ipylab
					numpy
					pandas
					matplotlib
				]))
			];
			shellHook = ''
				echo " JupyterLab ii pregatit. Sa ii dam drumul cu comanda => 'jupyter lab' "
			'';
		};
	};
}
