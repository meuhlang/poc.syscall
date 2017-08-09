; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-darwin16.6.0"

@syscallExit = constant i64 33554433; Equal to 0x2000001
@syscallWrite = constant i64 33554436; Equal to 0x2000004

declare i32 @main(i32, i8**, i32, i8**)
declare i32 @computeNullArrayLength(i8** %array)
declare i64 @_write(i32 %fd, i8* %str, i64 %nbyte)
declare void @_exit(i32 %status) noreturn

define i32 @start(i32 %argc, i8** %argv) {
    %i = add i32 %argc, 1
    %envp = getelementptr inbounds i8*, i8** %argv, i32 %i
    %envc = call i32 @computeNullArrayLength(i8** %envp)
    %ret = call i32 @main(i32 %argc, i8** %argv, i32 %envc, i8** %envp)
    call void @_exit(i32 %ret)

    unreachable
}
