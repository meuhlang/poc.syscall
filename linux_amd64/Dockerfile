FROM debian:buster-20210511

WORKDIR /opt/src/poc.syscall

COPY ./linux_amd64/llvm.ll ./llvm/linux_amd64.ll
COPY ./common/llvm.ll ./llvm/main.ll
COPY ./common/llvm.amd64.ll ./llvm/amd64.ll
COPY ./linux_amd64/nasm.asm ./nasm/full.asm

RUN set -eux; \
    apt-get update; \
    apt-get install -y \
        llvm=1:7.0-47 \
        nasm=2.14-1

RUN apt-get install -y lld=1:7.0-47
RUN apt-get install -y binutils=2.31.1-16


# Build with nasm
RUN set -eux; \
    cd nasm; \
    nasm -f elf64 -o full.o full.asm; \
    ld.lld -o binary.lld full.o; \
    ld -o binary.ld full.o

# Build with llvm
RUN set -eux; \
    cd llvm; \
	llvm-link main.ll linux_amd64.ll amd64.ll -o full.bc; \
	llc -march=x86-64 -filetype=obj -o full.o full.bc; \
    ld.lld -o binary.lld full.o; \
    ld -o binary.ld full.o
