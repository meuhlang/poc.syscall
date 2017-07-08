; vim:set ts=4 sw=4 tw=100 et:

global start

section .text

start:
    call    _print
    call    _exit

_print:
    mov     rax, 0x2000004 ; write
    mov     rdi, 1 ; stdout
    mov     rsi, msg
    mov     rdx, msg.len
    syscall
    ret

_exit:
    mov     rax, 0x2000001 ; exit
    mov     rdi, 12
    syscall
    ret

section .data

msg:    db  "Hello, world!", 10
.len:   equ $ - msg
