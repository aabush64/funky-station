{
  description = "Development environment for Space Station 14";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";

  outputs =
    { self
    , nixpkgs
    }:
    let
      systems = [ "x86_64-linux" ];
      buildAllSystems = output: builtins.foldl' nixpkgs.lib.recursiveUpdate { } (builtins.map output systems);
    in
    buildAllSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        buildStation = scriptarg: (import ./nix/shell.nix { inherit pkgs; scriptAdd = scriptarg; });
      in
      {
        packages."${system}".default = pkgs.callPackage ./nix/package.nix {};
        devShells."${system}" =
          let
            git = "git submodule update --init --recursive";
            bld = "dotnet build -c";
            run = "dotnet run --project";
          in
          {
            default = buildStation "";

            devTest = buildStation ''
              ${git}
              ${bld} Debug
              ${run} Content.Server --no-build & ${run} Content.Client --no-build
            '';
            mapping = buildStation ''
              ${git}
              ${bld} Tools
              ${run} Content.Server --no-build & ${run} Content.Client --no-build
            '';
            roundSim = buildStation ''
              ${git}
              ${bld} Release
              ${run} Content.Server --no-build & ${run} Content.Client --no-build
            '';

            buildDebug = buildStation ''
              ${git}
              ${bld} Debug
            '';
            buildRelease = buildStation ''
              ${git}
              ${bld} Release
            '';
            buildTools = buildStation ''
              ${git}
              ${bld} Tools
            '';

            runAll = buildStation ''
              ${run} Content.Server --no-build
              ${run} Content.Client --no-build
            '';
            runClient = buildStation ''
              ${run} Content.Client --no-build
            '';
            runServer = buildStation ''
              ${run} Content.Server --no-build
            '';

            test = buildStation "";
            testIntegration = buildStation "";
            testYaml = buildStation "";
          };
      }
    );
}
