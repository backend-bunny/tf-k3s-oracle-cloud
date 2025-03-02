{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, sops-nix, ...}: {
    nixosConfigurations.k3s-cp-2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./nix/k3s-control-plane-2.nix
      ];
    };
    nixosConfigurations.k3s-cp-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./nix/k3s-control-plane-1.nix
      ];
    };
    nixosConfigurations.k3s-worker = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./nix/k3s-worker.nix
      ];
    };
  };
}
