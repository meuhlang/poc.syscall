; vim:set ts=4 sw=4 tw=80 et:
; https://www.freebsd.org/doc/en/books/developers-handbook/x86-system-calls.html

global  start

section .text

start:
    call    _print
    call    _exit

; Print "Hello, world!\n" to STDOUT
_print:
    ; Prepare stack
    push    dword msg.len
    push    dword msg
    push    dword 1

    ; Set system call number
    ; ssize_t write(int fd, const void *buf, size_t nbyte);
    mov     eax, 4

    ; Perform system call
    call    _kernel

    ; Clean the stack
    add     esp, 12

    ret

; Perform an _exit(12)
_exit:
    ; Prepare the stack
    push    dword 12

    ; Set system call number
    ; void exit(int rval);
    mov     eax, 1

    ; Perform system call
    call    _kernel

    ret

; Perform an system call with a prepared stack
_kernel:
    int     0x80
    ret

section .data

msg:    db  "Hello, world!", 10
.len:   equ $ - msg
