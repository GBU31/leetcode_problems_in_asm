``` shell
nasm -f elf32 2_sum.asm -o 2_sum.o
gcc -m32 -nostartfiles 2_sum.o -o 2_sum
./2_sum
