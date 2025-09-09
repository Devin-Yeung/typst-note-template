{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/packages/
  packages = [ ];

  # https://devenv.sh/languages/
  languages.typst.enable = true;

  enterShell = ''
    typst --version
    typstyle --version
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    typstyle --version | grep --color=auto "${pkgs.typstyle.version}"
    typst --version | grep --color=auto "${pkgs.typst.version}"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    trim-trailing-whitespace = {
      enable = true;
    };

    yamlfmt = {
      enable = true;
    };

    treefmt = {
      enable = true;
    };

  };

  # See full reference at https://devenv.sh/reference/options/
}
