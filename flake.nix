{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Build the official MCP inspector (TypeScript version)
        mcp-inspector = pkgs.writeShellScriptBin "mcp-inspector" ''
          ${pkgs.nodejs}/bin/npx @modelcontextprotocol/inspector "$@"
        '';
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.go
            pkgs.gopls
            pkgs.golangci-lint
            pkgs.ollama
            pkgs.nodejs
            mcp-inspector
          ];
          
          shellHook = ''
            echo "MCP development shell ready!"
            echo "Run: mcp-inspector ./server/server"
          '';
        };
      }
    );
}
