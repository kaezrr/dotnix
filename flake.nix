{

  description = "My nixos system configuration!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };

}
