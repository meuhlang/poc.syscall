<!-- vim:set ts=4 sw=4 tw=100 et: -->

# Just play to implement syscall on various OS/ARCH

Thoses stacks are tested :
- `nasm` & `ld`
- `llvm-llc` & `llvm-lld`

[C declaration](https://en.wikipedia.org/wiki/X86_calling_conventions#cdecl) calling convention is
used.

# Some literature
- System calls
    - http://www.int80h.org/
    - https://www.freebsd.org/doc/en/books/developers-handbook/x86-system-calls.html
    - https://filippo.io/making-system-calls-from-assembly-in-mac-os-x/
- Assembly
    - http://www.nasm.us/
	- https://en.wikibooks.org/wiki/X86_Assembly
	- https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf
