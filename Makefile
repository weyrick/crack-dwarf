

all:
	clang -g -O0 segfault_c.c -o segfault_c
	clang -g -O0 segfault_c.c -o segfault_c.bc -emit-llvm -c
	llvm-dis segfault_c.bc
	crackc -g -O0 -n segfault_crk.crk
	crackc -g -O0 -n -d segfault_crk.crk > segfault_crk.ll
	clang -g -O0 -c simple_c2.c -o simple_c2.bc -emit-llvm
	clang -g -O0 -c simple_c.c -o simple_c.bc -emit-llvm
	llvm-ld -disable-opt simple_c.bc simple_c2.bc -o simple_final
	llvm-dis simple_final.bc
	crackc -g -O0 -n simple_crk.crk
	crackc -g -O0 -n -d simple_crk.crk > simple_crk.ll

clean: 
	rm -f *.o *.bc *.ll *~ simple_crk simple_final segfault_crk simple_c segfault_c


