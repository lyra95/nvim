{
  config,
  lib,
  ...
}: {
  options.copilot.enable = lib.mkEnableOption "use copilot";

  # need to run :Copilot setup once
  config = lib.mkIf config.copilot.enable {
    global.copilot_no_tab_map = true;
    plugins = {
      copilot-vim.enable = true;
      cmp = {
        enable = true;
        settings.mapping."<C-CR>" = ''
          function(fallback)
            if vim.fn["copilot#Accept"]() ~= "" then
              return
            end
            fallback() -- If no Copilot suggestion, fallback to normal behaviorend
          end
        '';
      };
    };
  };
}
