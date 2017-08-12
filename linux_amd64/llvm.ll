; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@syscallExit = constant i64 60
@syscallWrite = constant i64 1

declare i32 @main(i32, i8**, i32, i8**)
declare i32 @computeNullArrayLength(i8** %array)
declare void @_exit(i32 %status) noreturn

declare i8* @llvm.frameaddress(i32)

; 64bits Stack frame
;
; Purpose                 | Start Addresses
; -----------------------------------------------------------
; 0                       |
; Environment pointers... | %bbp+3+%argc
; 0                       | %rbp+2+%argc
; Argument pointers...    | From %rbp+2 to %rbp+2+argc-1
; Argument count (argc)   | %rbp+1
; -------- Above=Previous Frame  Below=Current Frame --------
; Return value            | %rbp

define i32 @_start() {
    %fp8 = call i8* @llvm.frameaddress(i32 0)
    %fp64 = bitcast i8* %fp8 to i64*

    %argcp64 = getelementptr i64, i64* %fp64, i32 1
    %argcp32 = bitcast i64* %argcp64 to i32*
    %argc = load i32, i32* %argcp32

    %argv0p64 = getelementptr i64, i64* %fp64, i32 2
    %argv = bitcast i64* %argv0p64 to i8**

    %envpIndex = add i32 %argc, 3
    %env0p64 = getelementptr i64, i64* %fp64, i32 %envpIndex
    %envp = bitcast i64* %env0p64 to i8**
    %envc = call i32 @computeNullArrayLength(i8** %envp)

    %ret = call i32 @main(
        i32 %argc, i8** %argv,
        i32 %envc, i8** %envp
    )

    call void @_exit(i32 %ret)
    unreachable
}
