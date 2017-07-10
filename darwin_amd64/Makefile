NASM=/usr/local/Cellar/nasm/2.13.01/bin/nasm
LLI=/usr/local/Cellar/llvm/4.0.1/bin/lli

all: nasm.ld lli

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	$(NASM) -f macho64 -o object.o nasm.asm

link.ld:
	@echo "= Link: ld ============================="
	ld -o binary object.o

nasm.ld: | clean build.nasm link.ld run

run:
	@echo "= Determine file type =================="
	file binary
	@echo "= Show symbol =========================="
	otool -L binary
	@echo "= Disasembly ==========================="
	otool -tv binary
	@echo "= Execute binary ======================="
	./binary; echo Return code $$?

lli:
	@echo "= Execute llvm-lli ====================="
	$(LLI) llvm.ll; echo Return code $$?
