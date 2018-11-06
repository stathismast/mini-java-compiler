@.Example1_vtable = global [0 x i8*] []
@.Test1_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32, i1)* @Test1.Start to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 12)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test1_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i32, i1)*
    %_8 = call i32 %_7(i8* %_0, i32 5, i1 1)
    call void @print_int(i32 %_8)
    ret i32 0
}

define i32 @Test1.Start(i8* %this, i32 %.b, i1 %.c) {
    %b = alloca i32
    store i32 %.b, i32* %b

    %c = alloca i1
    store i1 %.c, i1* %c

    %ntb = alloca i1

    %nti = alloca i32*

    %ourint = alloca i32

    %_9 = load i32, i32* %b
    %_10 = add i32 %_9, 1
    %_11 = call i8* @calloc(i32 4, i32 %_10)
    %_12 = bitcast i8* %_11 to i32*
    store i32 %_9, i32* %_12
    store i32* %_12, i32** %nti

    %_13 = load i32*, i32** %nti
    %_14 = icmp slt i32 0, 0
    br i1 %_14, label %Label2, label %Label0

Label0:
    %_15 = getelementptr i32, i32* %_13, i32 0
    %_16 = load i32, i32* %_15
    %_17 = icmp slt i32 0, %_16
    br i1 %_17, label %Label1, label %Label2

Label1:
    %_18 = add i32 0, 1
    %_19 = getelementptr i32, i32* %_13, i32 %_18
    %_20 = load i32, i32* %_19
    br label %Label3

Label2:
    call void @throw_oob()
    br label %Label3

Label3:
    store i32 %_20, i32* %ourint

    %_21 = load i32, i32* %ourint
    call void @print_int(i32 %_21)
    %_22 = load i32*, i32** %nti
    %_23 = icmp slt i32 0, 0
    br i1 %_23, label %Label6, label %Label4

Label4:
    %_24 = getelementptr i32, i32* %_22, i32 0
    %_25 = load i32, i32* %_24
    %_26 = icmp slt i32 0, %_25
    br i1 %_26, label %Label5, label %Label6

Label5:
    %_27 = add i32 0, 1
    %_28 = getelementptr i32, i32* %_22, i32 %_27
    %_29 = load i32, i32* %_28
    br label %Label7

Label6:
    call void @throw_oob()
    br label %Label7

Label7:
    ret i32 %_29
}
