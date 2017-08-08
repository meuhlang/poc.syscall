all:
	$(MAKE) nasm.ld
	$(MAKE) llc.ld

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	nasm -f elf64 -o object.o nasm.asm

build.llc:
	@echo "= Build: llc ==========================="
	llvm-link ../common/llvm.ll ../common/llvm.amd64.ll llvm.ll -o llvm.bc
	llc -march=x86-64 -filetype=obj -o object.o llvm.bc
	file object.o

link.ld:
	@echo "= Link: ld ============================="
	ld -o binary object.o

nasm.ld: | clean build.nasm link.ld run
llc.ld: | clean build.llc link.ld run

run:
	@echo "= Determine file type =================="
	file binary
	@echo "= Execute binary ======================="
	./binary; echo Return code $$?
