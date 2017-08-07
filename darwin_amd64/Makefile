NASM=/usr/local/opt/nasm/bin/nasm
LINK=/usr/local/opt/llvm/bin/llvm-link
LLC=/usr/local/opt/llvm/bin/llc
LLI=/usr/local/opt/llvm/bin/lli

all:
	$(MAKE) nasm.ld
	$(MAKE) llc.ld
	$(MAKE) lli

clean:
	@echo "= Clean ================================"
	rm -f object.o binary

build.nasm:
	@echo "= Build: nasm =========================="
	$(NASM) -f macho64 -o object.o nasm.asm

build.llc:
	@echo "= Build: llc ==========================="
	$(LINK) ../common/llvm.ll llvm.ll -o llvm.bc
	$(LLC) -march=x86-64 -filetype=obj -o object.o llvm.bc

link.ld:
	@echo "= Link: ld ============================="
	ld $(LDFLAGS) -o binary object.o

nasm.ld: | clean build.nasm link.ld run

llc.ld: LDFLAGS = -e _start -lSystem -macosx_version_min 10.12
llc.ld: | clean build.llc link.ld run

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
