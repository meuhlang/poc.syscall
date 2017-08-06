all:
	echo $(MAKE) nasm.ld
	$(MAKE) llc.ld.ld

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	nasm -f elf64 -o object.o nasm.asm

build.llc:
	@echo "= Build: llc ==========================="
	llc -march=x86-64 -filetype=obj -o object.o llvm.ll
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
