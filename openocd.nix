{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  libtool,
  libusb1,
  libftdi1,
  libyaml,
  automake,
  tcl,
  autoconf,
  which,
  texinfo,
}:
stdenv.mkDerivation rec {
  pname = "openocd-riscv";
  version = "unstable-2025-03-10";

  src = fetchFromGitHub {
    owner = "SpinalHDL";
    repo = "openocd_riscv";
    rev = "a0220ad302589de0e9ed41344ccf5a87118cf54b";
    hash = "sha256-/l3nE/tUhGWlc8iC3CoFXeXXfkGfZ6S0ch9IhYqRCuE=";
    # hash = "sha256-TGFkD6UetmChI6XFD67IWu1hv8XZ3t3WTo8BYRKxvDg=";
    fetchSubmodules = true;
    # deepClone = true;
    # leaveDotGit = true;
  };
  # sudo apt-get install libtool automake libusb-1.0.0-dev texinfo libusb-dev libyaml-dev pkg-config
  nativeBuildInputs = [
    # autoreconfHook
    automake
    pkg-config
    texinfo
    which
    tcl
    autoconf
  ];

  buildInputs = [
    libtool
    libusb1
    libyaml
    libftdi1
  ];

  preConfigure = ''
    ./bootstrap nosubmodule
  '';

  preAutoreconf = ''
    autoupdate
  '';

  configureFlags = [
    "--enable-ftdi"
    "--enable-jtag_vpi"
    "--enable-dummy"
  ];

  preferLocalBuild = true;

  meta = {
    description = "Spen's Official OpenOCD Mirror";
    homepage = "https://github.com/SpinalHDL/openocd_riscv";
    changelog = "https://github.com/SpinalHDL/openocd_riscv/blob/${src.rev}/NEWS";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "openocd";
    platforms = ["x86_64-linux"];
  };
}
