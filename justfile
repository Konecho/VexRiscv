genfull:
    mill VexRiscv.runMain vexriscv.demo.GenFull

gensmall:
    mill VexRiscv.runMain vexriscv.demo.GenSmallest

briey:
    mill VexRiscv.runMain vexriscv.demo.Briey

# To generate the SoC without any content in the ram
murax:
    mill VexRiscv.runMain vexriscv.demo.Murax

# To generate the SoC with a demo program already in ram
murax-ram:
    mill VexRiscv.runMain vexriscv.demo.MuraxWithRamInit

# This will generate the Murax RTL + run its testbench. 
murax-sim:
    mill VexRiscv.test.runMain vexriscv.MuraxSim

murax-openocd:
    openocd -f interface/jtag_tcp.cfg -c "set MURAX_CPU0_YAML {{justfile_directory()}}/cpu0.yaml" -f target/murax.cfg

murax-gdb:
    gdb src/test/resources/elf/uart.elf
    directory src/main/c/murax/hello_world/src
    target remote localhost:3333
    monitor reset halt
    load
    continue

murax-hello:
    #!/bin/sh
    TOOLCHAIN=$(dirname "$(which riscv32-none-elf-gcc)")/..
    cd src/main/c/murax/hello_world && RISCV_PATH=${TOOLCHAIN} RISCV_NAME=riscv32-none-elf  CFLAGS=-march=rv32im_zicsr  make

bsp:
    mill mill.bsp.BSP/install