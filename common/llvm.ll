; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

@str = internal constant [14 x i8] c"Hello, world!\0A"

declare i64 @_write(i32, i8*, i64)
declare void @_exit(i32) noreturn

define i32 @main() {
    %1 = call i64 @_write(i32 1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str, i32 0, i32 0), i64 14)
    %2 = trunc i64 %1 to i32
    ret i32 %2
}
