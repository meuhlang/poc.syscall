; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-darwin16.6.0"

@str = internal constant [14 x i8] c"Hello, world!\0A"
@syscallExit = internal constant i64 33554433; Equal to 0x2000001
@syscallWrite = internal constant i64 33554436; Equal to 0x2000004

define i32 @start() {
    %1 = call i32 @main()
    call void @_exit(i32 %1)

    ; Dead code
    ret i32 0
}

define i32 @main() {
    %1 = call i64 @_write(i32 1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str, i32 0, i32 0), i64 14)
    %2 = trunc i64 %1 to i32
    ret i32 %2
}

define i64 @_write(i32 %fd, i8* %str, i64 %nbyte) {
    %1 = load i64, i64* @syscallWrite
    %2 = call i64 asm sideeffect "syscall", "=A,{ax},{di},{si},{dx}"(i64 %1, i32 %fd, i8* %str, i64 %nbyte)
    ret i64 %2
}

define void @_exit(i32 %status) noreturn {
    %1 = load i64, i64* @syscallExit
    call void asm sideeffect "syscall", "{ax},{di}"(i64 %1, i32 %status)
    ret void
}

