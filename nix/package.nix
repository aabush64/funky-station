{ pkgs
, fetchFromGitHub
, buildDotnetModule

  # Dependencies
, dotnetCorePackages
, icu
, glfw
, SDL2
, libGL
, openal
, freetype
, fluidsynth
, soundfont-fluid
, gtk3
, pango
, cairo
, atk
, zlib
, glib
, gdk-pixbuf
, nss
, nspr
, at-spi2-atk
, libdrm
, expat
, libxkbcommon
, xorg
, mesa
, alsa-lib
, dbus
, at-spi2-core
, cups
, python3

  # Custom Args
, platform ? "client"
, build ? "Release"
}:

buildDotnetModule {
  pname = "FunkyStation-${platform}-${build}";
  version = "0.0";

  src = fetchFromGitHub {
    owner = "aabush64";
    repo = "funky-station";
    rev = "7d2cee1be98d405b4b0fd5abe02a0ee4856f9e07";
    hash = "sha256-5bGtDskOggX142UkX3QjoIa+/IunNAG3F6I6gJDL71E=";

    fetchSubmodules = true;
  };

  #src = ../.;

  projectFile = "SpaceStation14.sln";
  #dotnet-sdk = (with dotnetCorePackages; combinePackages [ sdk_9_0-bin sdk_8_0-bin ]);
  #dotnet-runtime = (with dotnetCorePackages; combinePackages [ runtime_9_0-bin sdk_8_0-bin ]);

  dotnet-sdk = dotnetCorePackages.sdk_8_0-bin;
  dotnet-runtime = dotnetCorePackages.runtime_8_0-bin;

  buildType = build;

  nugetDeps = ../deps.json;
  runtimeDeps = [
    icu
    glfw
    SDL2
    libGL
    openal
    freetype
    fluidsynth
    soundfont-fluid
    gtk3
    pango
    cairo
    atk
    zlib
    glib
    gdk-pixbuf
    nss
    nspr
    at-spi2-atk
    libdrm
    expat
    libxkbcommon
    xorg.libxcb
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxshmfence
    mesa
    alsa-lib
    dbus
    at-spi2-core
    cups
    python3
  ];

  packNupkg = false;

}
