@.ArrayTest_vtable = global [0 x i8*] []
@.Test_vtable = global [1 x i8*] [i8* bitcast (i1 (i8*, i32)* @Test.start to i8*)]

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
    %n = alloca i1

    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*, i32)*
    %_8 = call i1 %_7(i8* %_0, i32 10)
    store i1 %_8, i1* %n

    ret i32 0
}

define i1 @Test.start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz

    %b = alloca i32*

    %l = alloca i32

    %i = alloca i32

    %_9 = load i32, i32* %sz
    %_10 = add i32 %_9, 1
    %_11 = call i8* @calloc(i32 4, i32 %_10)
    %_12 = bitcast i8* %_11 to i32*
    store i32 %_9, i32* %_12
    store i32* %_12, i32** %b

    %_13 = load i32*, i32** %b
    %_14 = getelementptr i32, i32* %_13, i32 0
    %_15 = load i32, i32* %_14
    store i32 %_15, i32* %l

    store i32 0, i32* %i

    br label %Label0
Label0:
    %_17 = load i32, i32* %i
    %_18 = load i32, i32* %l
    %_16 = icmp slt i32 %_17, %_18
    br i1 %_16, label %Label1, label %Label2
Label1:
    %_19 = load i32*, i32** %b
    %_20 = load i32, i32* %i
    %_21 = load i32, i32* %i
    %_22 = icmp slt i32 %_20, 0
    br i1 %_22, label %Label5, label %Label3

Label3:
    %_23 = getelementptr i32, i32* %_19, i32 0
    %_24 = load i32, i32* %_23
    %_25 = icmp slt i32 %_20, %_24
    br i1 %_25, label %Label4, label %Label5

Label4:
    %_26 = add i32 %_20, 1
    %_27 = getelementptr i32, i32* %_19, i32 %_26
    store i32 %_21, i32* %_27
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    %_29 = load i32*, i32** %b
    %_30 = load i32, i32* %i
    %_31 = icmp slt i32 %_30, 0
    br i1 %_31, label %Label9, label %Label7

Label7:
    %_32 = getelementptr i32, i32* %_29, i32 0
    %_33 = load i32, i32* %_32
    %_34 = icmp slt i32 %_30, %_33
    br i1 %_34, label %Label8, label %Label9

Label8:
    %_35 = add i32 %_30, 1
    %_36 = getelementptr i32, i32* %_29, i32 %_35
    %_37 = load i32, i32* %_36
    br label %Label10

Label9:
    call void @throw_oob()
    br label %Label10

Label10:
    call void @print_int(i32 %_37)
    %_39 = load i32, i32* %i
    %_38 = add i32 %_39, 1
    store i32 %_38, i32* %i

    br label %Label0
Label2:

    ret i1 1
}
