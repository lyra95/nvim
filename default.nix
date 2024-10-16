# 1. https://nix-community.github.io/nixvim/search/
# 2. https://nix-community.github.io/nixvim/user-guide/config-examples.html
# 3. https://grep.app/
{
  imports = [
    ./modules/bufferline.nix
    ./modules/lsp
  ];

  colorscheme = "catppuccin";
  colorschemes.catppuccin.enable = true;

  lsp-k8s.enable = true;

  globalOpts = {
    number = true;
    relativenumber = true;

    # reserve some space on the left for some icons (breakpoints, warning, etc)
    signcolumn = "yes";

    cursorline = true;
  };

  plugins = {
    nvim-autopairs.enable = true;
    lualine.enable = true;
    # need to run :Copilot setup once
    copilot-vim.enable = true;
    cmp.enable = true;
    cmp.settings.sources = [
      {name = "nvim_lsp";}
      {name = "path";}
      {name = "buffer";}
      {name = "treesitter";}
    ];
    cmp-treesitter.enable = true;
    treesitter.enable = true;
    treesitter.folding = true;

    telescope.enable = true;
    telescope.extensions.ui-select.enable = true;

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
}
