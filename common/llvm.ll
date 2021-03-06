; vim:set sts=0 ts=4 sw=4 tw=100 et:

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

@printArgv = internal constant [18 x i8] c"The ARGV content:\00"
@printEnvp = internal constant [19 x i8] c"\0AThe ENVP content:\00"
@str = internal constant [29 x i8] c"Arguments array is empty !!!\00"
@newLine = internal constant [1 x i8] c"\0A"

declare i64 @_write(i32, i8*, i64)
declare void @_exit(i32) noreturn

define i32 @main(i32 %argc, i8** %argv, i32 %envc, i8** %envp) {
    call i64 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @printArgv, i32 0, i32 0))
    call void @printArgs(i32 %argc, i8** %argv)
    call i64 @puts(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @printEnvp, i32 0, i32 0))
    call void @printArgs(i32 %envc, i8** %envp)
    ret i32 %argc
}

define void @printArgs(i32 %argc, i8** %argv) {
    %isEmpty = icmp eq i32 %argc, 0
    br i1 %isEmpty, label %cond.isEmpty, label %cond.isNotEmpty

cond.isEmpty:
    call i64 @puts(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @str, i32 0, i32 0))
    ret void

cond.isNotEmpty:
    %iptr = alloca i32
    store i32 0, i32* %iptr
    br label %for.cond

for.cond:
    %i = load i32, i32* %iptr
    %isLower = icmp slt i32 %i, %argc
    br i1 %isLower, label %for.body, label %for.end

for.body:
    %strPtr = getelementptr inbounds i8*, i8** %argv, i32 %i
    %str = load i8*, i8** %strPtr
    call i64 @puts(i8* %str)
    %newi = add i32 %i, 1
    store i32 %newi, i32* %iptr
    br label %for.cond

for.end:
    ret void
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

define i32 @computeNullArrayLength(i8** %array) {
    %iptr = alloca i32
    store i32 0, i32* %iptr
    br label %for.cond

for.cond:
    %i = load i32, i32* %iptr
    %varPtr = getelementptr inbounds i8*, i8** %array, i32 %i
    %var = load i8*, i8** %varPtr
    %isNull = icmp eq i8* %var, null
    br i1 %isNull, label %for.end, label %for.body

for.body:
    %newi = add i32 %i, 1
    store i32 %newi, i32* %iptr
    br label %for.cond

for.end:
    %ret = load i32, i32* %iptr
    ret i32 %ret
}
