@.ArrayInit_vtable = global [0 x i8*] []

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"

define void @print_int(i32 %i) {
    %_str = bitcast [4 x i8]* @_cint to i8*
    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
    ret void
}

define void @throw_oob() {
    %_str = bitcast [15 x i8]* @_cOOB to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() {
    %array = alloca i32*

    %_0 = add i32 5, 1
    %_1 = call i8* @calloc(i32 4, i32 %_0)
    %_2 = bitcast i8* %_1 to i32*
    store i32 5, i32* %_2
    store i32* %_2, i32** %array

    %_3 = load i32*, i32** %array
    %_4 = icmp slt i32 2, 0
    br i1 %_4, label %Label2, label %Label0

Label0:
    %_5 = getelementptr i32, i32* %_3, i32 0
    %_6 = load i32, i32* %_5
    %_7 = icmp slt i32 2, %_6
    br i1 %_7, label %Label1, label %Label2

Label1:
    %_8 = add i32 2, 1
    %_9 = getelementptr i32, i32* %_3, i32 %_8
    %_10 = load i32, i32* %_9
    br label %Label3

Label2:
    call void @throw_oob()
    br label %Label3

Label3:
    call void @print_int(i32 %_10)
    ret i32 0
}
