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
    self,
    nixpkgs,
    flake-utils,
    nixvim,
    ...
  }:
    (let
      # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/8
      # import vs legacyPackages
      # the latter has performance gain
      pkgsBuilder = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      nixvimBuilder = pkgs: system: let
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = {
            imports = [
              self.nixvimModules.default
              ./default.nix
            ];
          };
          extraSpecialArgs = {};
        };
      in
        nixvim'.makeNixvimWithModule nixvimModule;
    in
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = pkgsBuilder system;
        nvim = nixvimBuilder pkgs system;
      in {
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {packages = [nvim];};
        packages.default = nvim;
      }))
    // {
      nixvimModules = let
        modules = {
          folding = ./modules/folding.nix;
          completion = ./modules/completion.nix;
          telescope = ./modules/telescope.nix;
        };
        all = {
          imports = builtins.attrValues modules;
        };
      in
        modules // {default = all;};
    };
}
