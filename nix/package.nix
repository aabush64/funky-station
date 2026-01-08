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
    rev = "";
    hash = "";

    fetchSubmodules = true;
  };

  #src = ../.;

  projectFile = "SpaceStation14.sln";
  dotnet-sdk = dotnetCorePackages.sdk_9_0-bin;
  dotnet-runtime = dotnetCorePackages.runtime_9_0-bin;

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
