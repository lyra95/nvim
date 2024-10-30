{
  config,
  lib,
  ...
}: {
  options.neo-tree = {
    enable = lib.mkEnableOption "use neotree";
    enableBufferlineIntegration = lib.mkEnableOption "enable bufferline integration";
  };

  config = lib.mkIf config.neo-tree.enable {
    plugins.neo-tree = {
      enable = true;
      filesystem = {
        filteredItems = {
          hideDotfiles = false;
          hideGitignored = false;
        };
      };
      defaultComponentConfigs = {
        indent = {
          withExpanders = true;
          expanderCollapsed = "󰅂";
          expanderExpanded = "󰅀";
          expanderHighlight = "NeoTreeExpander";
        };

        gitStatus = {
          symbols = {
            added = " ";
            conflict = "󰩌 ";
            deleted = "󱂥";
            ignored = " ";
            modified = " ";
            renamed = "󰑕";
            staged = "󰩍";
            unstaged = "";
            untracked = " ";
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "toggle Neotree";
        };
      }
    ];

    plugins.bufferline.offsets = lib.mkIf config.neo-tree.enableBufferlineIntegration [
      {
        filetype = "neo-tree";
        text = "Neo-tree";
        highlight = "Directory";
        text_align = "left";
      }
    ];
  };
}
