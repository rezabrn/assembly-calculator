#!/bin/bash
nasm -f elf $1.asm
nasm -f elf -d ELF_TYPE asm_io.asm
gcc -m32 -c driver.c
gcc -m32 *.o -o $1.out
./$1.out

