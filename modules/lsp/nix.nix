{pkgs, ...}: {
  extraPackages = [pkgs.alejandra];

  plugins = {
    lsp = {
      servers = {
        nil-ls.enable = true;
        nil-ls.settings.formatting.command = ["alejandra"];
        nil-ls.settings.nix.flake.autoArchive = true; # setting true, this would use networks to fetch codes
        nixd.enable = true;
      };
    };
  };
}
