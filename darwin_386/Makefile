NASM=/usr/local/opt/nasm/bin/nasm

all: nasm.ld

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	$(NASM) -f macho -o object.o nasm.asm

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
