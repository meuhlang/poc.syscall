; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

@syscallExit = external constant i64
@syscallWrite = external constant i64

define i64 @_write(i32 %fd, i8* %str, i64 %nbyte) {
    %1 = load i64, i64* @syscallWrite
    %2 = call i64 asm sideeffect "syscall", "=A,{ax},{di},{si},{dx}"(i64 %1, i32 %fd, i8* %str, i64 %nbyte)
    ret i64 %2
}

define void @_exit(i32 %status) noreturn {
    %1 = load i64, i64* @syscallExit
    call void asm sideeffect "syscall", "{ax},{di}"(i64 %1, i32 %status)

    unreachable
}

