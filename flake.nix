{
  description = "My neovim setup";

  inputs = {
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    nixvim,
    ...
  }: let
    # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/8
    # import vs legacyPackages
    # the latter has performance gain
    pkgsBuilder = system: nixpkgs.legacyPackages.${system};
    nixvimBuilder = system: let
      nixvim' = nixvim.legacyPackages.${system};
      nixvimModule = {
        pkgs = pkgsBuilder system;
        module = import ./default.nix;
        extraSpecialArgs = {};
      };
    in
      nixvim'.makeNixvimWithModule nixvimModule;
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = pkgsBuilder system;
      nvim = nixvimBuilder system;
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.mkShell {packages = [nvim];};
      packages.default = nvim;
    });
}
