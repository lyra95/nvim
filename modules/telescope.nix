{
  config,
  lib,
  ...
}: {
  options.telescope.enable = lib.mkEnableOption "use telescope";
  config = lib.mkIf config.telescope.enable {
    plugins = {
      telescope.enable = true;
      telescope.extensions.ui-select.enable = true;
      telescope.keymaps = {
        "<S-S>" = {
          action = "git_files";
          options = {
            desc = "Search files (respecting .gitignore)";
          };
        };
        "<C-S-F>" = {
          action = "live_grep";
          options.desc = "Search through files by keywords";
        };
      };
    };
  };
}
