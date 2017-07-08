; vim:set ts=4 sw=4 tw=100 et:

global  start

section .text

; Program entry point
start:
    push    dword msg.len ; Message length
    push    dword msg ; Message pointer
    push    dword 1 ; stdout
    call    _write
    add     esp, 12 ; Clean stack

    push    dword eax
    call    _exit
    ; There is no return from _exit


; Perform syscall number 4
; ssize_t write(int fd, const void *buf, size_t nbyte)
_write:
    %stacksize flat
    %arg fd:dword
    %arg buf:dword
    %arg nbyte:dword
    enter   0, 0 ; Create a new stack frame

    mov     eax, 4 ; Set syscall number

    ; Prepare arguments stack for syscall
    push    dword [nbyte]
    push    dword [buf]
    push    dword [fd]

    ; Perform system call
    call    _kernel

    ; Clean the stack
    leave

    ret


; Perform syscall number 1
; void exit(int status)
_exit:
    %stacksize flat
    %arg status:dword
    enter   0,0 ; Create a new stack frame

    mov     eax, 1 ; Set syscall number

    ; Prepare arguments stack for syscall
    push    dword [status] ;

    ; Perform system call
    call    _kernel

    ; There is not return from this syscall
    ; No need to 'leave' or 'ret'


; Perform an system call with a prepared stack
; Change of the prepared stack will break syscall ABI
; => Do not create new stack frame
_kernel:
    int     0x80
    ret

section .data

msg:    db  "Hello, world!", 10
.len:   equ $ - msg
