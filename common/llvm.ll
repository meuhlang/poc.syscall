; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

@str = internal constant [14 x i8] c"Hello, world!\00"
@newLine = internal constant [1 x i8] c"\0A"

declare i64 @_write(i32, i8*, i64)
declare void @_exit(i32) noreturn

define i32 @main() {
    %1 = call i64 @puts(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str, i32 0, i32 0))
    %2 = trunc i64 %1 to i32
    ret i32 %2
}

define i32 @strlen(i8* %str) {
    %iptr = alloca i32
    store i32 0, i32* %iptr
    br label %for.cond

for.cond:
    %i = load i32, i32* %iptr
    %cptr = getelementptr inbounds i8, i8* %str, i32 %i
    %c = load i8, i8* %cptr
    %isEnd = icmp ne i8 %c, 0
    br i1 %isEnd, label %for.body, label %for.end

for.body:
    %newi = add i32 %i, 1
    store i32 %newi, i32* %iptr
    br label %for.cond

for.end:
    %ret = load i32, i32* %iptr
    ret i32 %ret
}

define i64 @puts(i8* %str) {
    %len32 = call i32 @strlen(i8* %str)
    %len64 = sext i32 %len32 to i64
    %writtenStr = call i64 @_write(i32 1, i8* %str, i64 %len64)
    %writtenNewLine = call i64 @_write(i32 1,
        i8* getelementptr inbounds ([1 x i8], [1 x i8]* @newLine, i32 0, i32 0), i64 1)
    %ret = add i64 %writtenStr, %writtenNewLine

    ret i64 %ret
}
