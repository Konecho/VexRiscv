{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        ## managed by sbt
        # scala_2_12
        ## sbt and mill will invoke jre
        sbt
        mill
        jre
        metals
        # openjdk17
        coursier
        # bloop
        ## formal
        symbiyosys
        yices
        verilator
        verilog
        gtkwave
        gdb

        # sudo apt-get install build-essential xorg-dev libudev-dev libgl1-mesa-dev libglu1-mesa-dev libasound2-dev libpulse-dev libopenal-dev libogg-dev libvorbis-dev libaudiofile-dev libpng12-dev libfreetype6-dev libusb-dev libdbus-1-dev zlib1g-dev libdirectfb-dev libsdl2-dev
        SDL2
      ];
      DISPLAY = ":0";
    };
  };
}
