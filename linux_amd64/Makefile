all:
	$(MAKE) nasm.ld
	$(MAKE) nasm.llvm
	$(MAKE) llvm.ld
	$(MAKE) llvm.llvm

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	nasm -f elf64 -o object.o nasm.asm

build.llvm:
	@echo "= Build: llvm =========================="
	llvm-link ../common/llvm.ll ../common/llvm.amd64.ll llvm.ll -o llvm.bc
	llc -march=x86-64 -filetype=obj -o object.o llvm.bc
	file object.o

link.ld:
	@echo "= Link: ld ============================="
	ld -o binary object.o

link.llvm:
	@echo "= Link: llvm ==========================="
	ld.lld-4.0 -o binary object.o

nasm.ld: | clean build.nasm link.ld run
nasm.llvm: | clean build.nasm link.llvm run
llvm.ld: | clean build.llvm link.ld run
llvm.llvm: | clean build.llvm link.llvm run

run:
	@echo "= Determine file type =================="
	file binary
	@echo "= Disasembly ==========================="
	objdump -d binary
	@echo "= Execute binary ======================="
	./binary "First arg" "Second arg"; echo Return code $$?
