@.OutOfBounds1_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.run to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*)*
    %_8 = call i32 %_7(i8* %_0)
    call void @print_int(i32 %_8)
    ret i32 0
}

define i32 @A.run(i8* %this) {
    %a = alloca i32*

    %_9 = add i32 20, 1
    %_10 = call i8* @calloc(i32 4, i32 %_9)
    %_11 = bitcast i8* %_10 to i32*
    store i32 20, i32* %_11
    store i32* %_11, i32** %a

    %_12 = load i32*, i32** %a
    %_13 = icmp slt i32 10, 0
    br i1 %_13, label %Label2, label %Label0

Label0:
    %_14 = getelementptr i32, i32* %_12, i32 0
    %_15 = load i32, i32* %_14
    %_16 = icmp slt i32 10, %_15
    br i1 %_16, label %Label1, label %Label2

Label1:
    %_17 = add i32 10, 1
    %_18 = getelementptr i32, i32* %_12, i32 %_17
    %_19 = load i32, i32* %_18
    br label %Label3

Label2:
    call void @throw_oob()
    br label %Label3

Label3:
    call void @print_int(i32 %_19)
    %_20 = load i32*, i32** %a
    %_21 = icmp slt i32 40, 0
    br i1 %_21, label %Label6, label %Label4

Label4:
    %_22 = getelementptr i32, i32* %_20, i32 0
    %_23 = load i32, i32* %_22
    %_24 = icmp slt i32 40, %_23
    br i1 %_24, label %Label5, label %Label6

Label5:
    %_25 = add i32 40, 1
    %_26 = getelementptr i32, i32* %_20, i32 %_25
    %_27 = load i32, i32* %_26
    br label %Label7

Label6:
    call void @throw_oob()
    br label %Label7

Label7:
    ret i32 %_27
}
