{ config, pkgs,... }:

let
  myConfig = pkgs.fetchFromGitHub {
    owner = "lesoup-mxd";
    repo = "nixconf";
  };
in
{
  imports = [
    (builtins.hasAttr "main" myConfig && myConfig.fetchedContent)
  ];
  # Additional imports to be listed here
}
