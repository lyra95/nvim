{
  config,
  lib,
  ...
}: {
  options = {
    folding.enable = lib.mkEnableOption "use folding";
  };

  # https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
  config = lib.mkIf config.folding.enable {
    # zo: open fold
    # zc: close fold
    # zO: open all folds
    # zC: close all folds
    # za: toggle fold (cursor doesn't need to be at fold)
    # zj, zk: move to next/previous fold
    keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action = "zo";
        options = {
          desc = "unfold";
        };
      }
      {
        mode = "n";
        key = "<S-CR>";
        options = {
          desc = "fold";
        };
        action = "zc";
      }
    ];

    opts = {
      foldlevelstart = 2;
      foldlevel = 99;
      foldminlines = 9;
    };

    plugins.treesitter.enable = true;
    plugins.treesitter.folding = true;
  };
}
