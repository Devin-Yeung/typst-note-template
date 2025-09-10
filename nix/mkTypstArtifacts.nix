{
  typixLib,
  flake-utils,
  name,
  commonArgs,
  src,
  unstable_typstPackages,
}:
let

  drvs = {
    # Compile a Typst project, *without* copying the result to the current directory
    "build-${name}-drv" = typixLib.buildTypstProject (
      commonArgs
      // {
        inherit src unstable_typstPackages;
      }
    );

    # Compile a Typst project, and then copy the result to the current directory
    "build-${name}-script" = typixLib.buildTypstProjectLocal (
      commonArgs
      // {
        inherit src unstable_typstPackages;
        typstOutput = "${name}.pdf";
      }
    );

    # Watch a project and recompile on changes
    "watch-${name}-script" = typixLib.watchTypstProject commonArgs;
  };

  apps = {
    "build-${name}" =
      flake-utils.lib.mkApp {
        drv = drvs."build-${name}-script";
      }
      // {
        meta = {
          description = "Build the ${name}";
        };
      };
    "watch-${name}" =
      flake-utils.lib.mkApp {
        drv = drvs."watch-${name}-script";
      }
      // {
        meta = {
          description = "Watch the ${name} for changes and recompile automatically";
        };
      };
  };
in
{
  inherit drvs apps;
}
