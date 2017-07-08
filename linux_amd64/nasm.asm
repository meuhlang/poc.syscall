; vim:set ts=4 sw=4 tw=100 et:

global _start

section .text

_start:
    mov     rdx, msg.len ; Message length
    mov     rsi, msg ; Message pointer
    mov     rdi, dword 1 ; stdout
    call    _write

    mov     rdi, rax
    call    _exit


; Perform syscall number 1
; ssize_t write(int fd, const void *buf, size_t nbyte)
_write:
    enter   0,0 ; Create a new stack frame

    mov     rax, 0x1 ; Set syscal number

    ; All parameters are setted with function call convention
    ; Just perform system call
    syscall

    ; Clean the stack
    leave

    ret


; Perform syscall number 60
; void exit(int status)
_exit:
    enter   0,0 ; Create a new stack frame

    mov     rax, 60 ; Set syscall number

    ; All parameters are setted with function call convention
    ; Just perform system call
    syscall

    ; There is not return from this syscall
    ; No need to 'leave' or 'ret'

section .data

msg:    db  "Hello, world!", 10
.len:   equ $ - msg
