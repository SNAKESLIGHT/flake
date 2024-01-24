{
  description = "SNAKESLIGHT's new flake for multiple machines";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    # nix com    extra-substituters = [munity's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    #homeManagerModules = [nixvim.homeManagerModules.nixvim];
  in {
    nixosConfigurations = {
      #2010 macbook pro
      nixbook = nixpkgs.lib.nixosSystem {

        modules = [
          ./hosts/nixbook

          home-manager.nixosModules.home-manager
          {
            home-manager = {
	    useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = inputs;
            users.snake.imports = [
		 ./home/hosts/nixbook
	     ];
	      #++ homeManagerModules;
	    };
          }
        ];
      };
      
      #thinkpad t430
      nixpad = nixpkgs.lib.nixosSystem {

        modules = [
          ./hosts/nixpad

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.snake = import ./home;
          }
        ];
      };
    };
  };
}
