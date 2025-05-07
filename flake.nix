{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, disko, ... }@inputs: {
        nixosConfigurations = {
            "home" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                        ./configuration.nix
                        ./hardware-configuration.nix
                        disko.nixosModules.disko
                        {
                            disko.devices = import ./disko.nix;
                        }

                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.kirill = import ./home.nix;
                        }
                ];
            };
        };
    };
}
