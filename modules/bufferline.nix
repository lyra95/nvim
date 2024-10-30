{
  config,
  lib,
  ...
}: {
  options.bufferline.enable = lib.mkEnableOption "use bufferline";

  config = lib.mkIf config.bufferline.enable {
    plugins = {
      bufferline = {
        enable = true;
        separatorStyle = "slope";
        diagnostics = "nvim_lsp";
      };
    };

    keymaps = let
      windows = [
        {
          mode = "n";
          key = "]]";
          options.desc = "Cycle to next window";
          action = "<cmd>wincmd w<CR>";
        }

        {
          mode = "n";
          key = "[[";
          options.desc = "Cycle to previous window";
          action = "<cmd>wincmd W<CR>";
        }

        {
          mode = "n";
          key = "<leader>h";
          options.desc = "split window horizontally left";
          action = "<cmd>leftabove vsplit<CR>";
        }

        {
          mode = "n";
          key = "<leader>l";
          options.desc = "split window horizontally right";
          action = "<cmd>rightbelow vsplit<CR>";
        }

        {
          mode = "n";
          key = "<leader>j";
          options.desc = "split window vertically below";
          action = "<cmd>below split<CR>";
        }

        {
          mode = "n";
          key = "<leader>k";
          options.desc = "split window vertically above";
          action = "<cmd>above split<CR>";
        }
      ];

      buffers = [
        {
          mode = "n";
          key = "]b";
          action = "<cmd>BufferLineCycleNext<cr>";
          options = {
            desc = "Cycle to next buffer";
          };
        }

        {
          mode = "n";
          key = "[b";
          action = "<cmd>BufferLineCyclePrev<cr>";
          options = {
            desc = "Cycle to previous buffer";
          };
        }

        {
          mode = "n";
          key = "<leader>bd";
          action = "<cmd>bdelete<cr>";
          options = {
            desc = "Delete buffer";
          };
        }

        {
          mode = "n";
          key = "<leader>bl";
          action = "<cmd>BufferLineCloseLeft<cr>";
          options = {
            desc = "Delete buffers to the left";
          };
        }

        {
          mode = "n";
          key = "<leader>bo";
          action = "<cmd>BufferLineCloseOthers<cr>";
          options = {
            desc = "Delete other buffers";
          };
        }

        {
          mode = "n";
          key = "<leader>bp";
          action = "<cmd>BufferLineTogglePin<cr>";
          options = {
            desc = "Toggle pin";
          };
        }

        {
          mode = "n";
          key = "<leader>bP";
          action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
          options = {
            desc = "Delete non-pinned buffers";
          };
        }
      ];
    in
      windows ++ buffers;
  };
}
