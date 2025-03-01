{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {nixpkgs, ...}: {
    nixosConfigurations.k3s-cp-2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/k3s-control-plane-2.nix
      ];
    };
    nixosConfigurations.k3s-cp-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/k3s-control-plane-1.nix
      ];
    };
    nixosConfigurations.k3s-worker = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/k3s-worker.nix
      ];
    };
  };
}
