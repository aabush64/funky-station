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

  #src = fetchFromGitHub {
  #  owner = "funky-station";
  #  repo = "funky-station";
  #  rev = "8042471671519453a06d1f266ad7b3ebb64b93b1";
  #  hash = "";

  #  fetchSubmodules = true;
  #};

  src = ./.;

  projectFile = "src/SpaceStation14.sln";
  dotnet-sdk = dotnetCorePackages.sdk_10_0-bin;
  dotnet-runtime = dotnetCorePackages.runtime_10_0-bin;

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
