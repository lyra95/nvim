{pkgs, ...}: {
  extraPackages = [pkgs.alejandra];

  plugins = {
    lsp = {
      servers = {
        nil-ls.enable = true;
        nil-ls.settings.formatting.command = ["alejandra"];
        nixd.enable = true;
      };
    };
  };
}
