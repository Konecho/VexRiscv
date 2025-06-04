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

        SDL2

        (callPackage ./openocd.nix {})

        pkgsCross.riscv32-embedded.buildPackages.gcc
      ];
      DISPLAY = ":0";
    };
  };
}
