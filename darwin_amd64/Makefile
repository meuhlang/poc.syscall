NASM=/usr/local/opt/nasm/bin/nasm
LINK=/usr/local/opt/llvm/bin/llvm-link
LLC=/usr/local/opt/llvm/bin/llc

all:
	$(MAKE) nasm.ld
	$(MAKE) llvm.ld

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	$(NASM) -f macho64 -o object.o nasm.asm

build.llvm:
	@echo "= Build: llvm =========================="
	$(LINK) ../common/llvm.ll ../common/llvm.amd64.ll llvm.ll -o llvm.bc
	$(LLC) -march=x86-64 -filetype=obj -o object.o llvm.bc

link.ld:
	@echo "= Link: ld ============================="
	ld $(LDFLAGS) -o binary object.o

nasm.ld: | clean build.nasm link.ld run

llvm.ld: LDFLAGS = -e _start -lSystem -macosx_version_min 10.12
llvm.ld: | clean build.llvm link.ld run

run:
	@echo "= Determine file type =================="
	file binary
	@echo "= Show symbol =========================="
	otool -L binary
	@echo "= Disasembly ==========================="
	otool -tv binary
	@echo "= Execute binary ======================="
	./binary; echo Return code $$?
