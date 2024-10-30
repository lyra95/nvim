# 1. https://nix-community.github.io/nixvim/search/
# 2. https://nix-community.github.io/nixvim/user-guide/config-examples.html
# 3. https://grep.app/
let
  modules = {
    themes = {
      colorscheme = "catppuccin";
      colorschemes.catppuccin.enable = true;
    };

    defaults = {
      globals.mapleader = " ";

      globalOpts = {
        number = true;
        relativenumber = true;

        # reserve some space on the left for some icons (breakpoints, warning, etc)
        signcolumn = "yes";

        cursorline = true;
      };
    };

    full = {
      folding.enable = true;
      completion.enable = true;
      telescope.enable = true;
      neo-tree.enable = true;
      neo-tree.enableBufferlineIntegration = true;
      bufferline.enable = true;

      lsp = {
        enable = true;
        k8s.enable = true;
        bash.enable = true;
        nix.enable = true;
      };
    };

    misc = {
      plugins = {
        nvim-autopairs = {
          enable = true;
          settings.check_ts = true;
        };
        lualine.enable = true;

        # # Linewise
        #
        # `gcw` - Toggle from the current cursor position to the next word
        # `gc$` - Toggle from the current cursor position to the end of line
        # `gc}` - Toggle until the next blank line
        # `gc5j` - Toggle 5 lines after the current cursor position
        # `gc8k` - Toggle 8 lines before the current cursor position
        # `gcip` - Toggle inside of paragraph
        # `gca}` - Toggle around curly brackets
        #
        # # Blockwise
        #
        # `gb2}` - Toggle until the 2 next blank line
        # `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
        # `gbac` - Toggle comment around a class (w/ LSP/treesitter support)
        comment.enable = true;
      };
    };
  };
in {
  imports = builtins.attrValues modules;
}
