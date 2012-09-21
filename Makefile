

all:
	
# segfault in c
	clang -w -g -O0 segfault_c.c -o segfault_c
	clang -w -g -O0 segfault_c.c -o segfault_c.bc -emit-llvm -c
	llvm-dis segfault_c.bc

# segfault in crack
	crackc -g -O0 -n segfault_crk.crk
	crackc -g -O0 -n -d segfault_crk.crk > segfault_crk.ll

# simple in c (two files to link, to match crack builtins)
	clang -g -O0 -c simple_c2.c -o simple_c2.bc -emit-llvm
	clang -g -O0 -c simple_c.c -o simple_c.bc -emit-llvm
	llvm-dis simple_c.bc
	llvm-dis simple_c2.bc
	llvm-ld -native -v -disable-opt simple_c.bc simple_c2.bc -o simple_final
	llvm-dis simple_final.bc

# simple in crack
	crackc -g -O0 -n simple_crk.crk
	crackc -g -O0 -n -d simple_crk.crk > simple_crk.ll

# we want these to be as close as possible
	dwarfdump simple_crk > simple_crk.dwarf
	dwarfdump simple_final > simple_final.dwarf


clean: 
	rm -f *.o *.bc *.ll *~ simple_crk simple_final segfault_crk simple_c segfault_c


