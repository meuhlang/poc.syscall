<!-- vim:set ts=4 sw=4 tw=100 et: -->

# Just play to implement syscall on various OS/ARCH

Supported platforms / build chain :

   OS  |  Arch  | nasm/ld | nasm/llvm | llvm/ld | llvm/llvm | Notes
-------|--------|---------|-----------|---------|-----------|-------
Darwin | x86-64 |   Yes   |     No    |   Yes   |     No    | No llvm-lld support
Linux  | x86-64 |   Yes   |   No yet  |   Yes   |   No yet  |

[C declaration](https://en.wikipedia.org/wiki/X86_calling_conventions#cdecl) calling convention is
used.

# Assumption
- syscall convention : All amd64 architectures use the same syscall convention

# Some literature
- Architecture
    - https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-2b-manual.html
    - https://software.intel.com/sites/default/files/article/402129/mpx-linux64-abi.pdf
    - http://courses.cs.washington.edu/courses/cse378/10au/sections/Section1_recap.pdf
- System calls
    - http://www.int80h.org/
    - https://www.freebsd.org/doc/en/books/developers-handbook/x86-system-calls.html
    - https://filippo.io/making-system-calls-from-assembly-in-mac-os-x/
- Assembly
    - http://www.nasm.us/
	- https://en.wikibooks.org/wiki/X86_Assembly
	- https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf
- MacOS
    - https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
