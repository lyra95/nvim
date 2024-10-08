{
  config,
  lib,
  ...
}: {
  options = {
    lsp-k8s.enable = lib.mkEnableOption "use k8s lsp (yaml, json, etc)";
  };
  config = lib.mkIf config.lsp-k8s.enable {
    plugins = {
      lsp.servers = {
        docker-compose-language-service.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        yamlls.extraOptions = {
          settings = {
            hover = true;
            completion = true;
            validate = true;
            yaml = {
              schemas = {
                # kubernetes = "";
                "https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta8.json" = "skaffold.yaml";
                "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                "http://json.schemastore.org/github-action" = ".github/*.{yml,yaml}";
                "http://json.schemastore.org/kustomization" = "*kustomization.{yml,yaml}";
                "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                "http://json.schemastore.org/prettierrc" = ".prettierrc.{yml,yaml}";
                "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "*docker-compose*.{yml,yaml}";
                "https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json" = "*.{yml,yaml}";
              };
            };
          };
        };
      };
    };
  };
}
