@.MoreThan4_vtable = global [0 x i8*] []
@.MT4_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*, i32, i32, i32, i32, i32, i32)* @MT4.Start to i8*), i8* bitcast (i32 (i8*, i32, i32, i32, i32, i32, i32)* @MT4.Change to i8*)]

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
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.MT4_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i32, i32, i32, i32, i32, i32)*
    %_8 = call i32 %_7(i8* %_0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6)
    call void @print_int(i32 %_8)
    ret i32 0
}

define i32 @MT4.Start(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
    %p1 = alloca i32
    store i32 %.p1, i32* %p1

    %p2 = alloca i32
    store i32 %.p2, i32* %p2

    %p3 = alloca i32
    store i32 %.p3, i32* %p3

    %p4 = alloca i32
    store i32 %.p4, i32* %p4

    %p5 = alloca i32
    store i32 %.p5, i32* %p5

    %p6 = alloca i32
    store i32 %.p6, i32* %p6

    %aux = alloca i32

    %_9 = load i32, i32* %p1
    call void @print_int(i32 %_9)
    %_10 = load i32, i32* %p2
    call void @print_int(i32 %_10)
    %_11 = load i32, i32* %p3
    call void @print_int(i32 %_11)
    %_12 = load i32, i32* %p4
    call void @print_int(i32 %_12)
    %_13 = load i32, i32* %p5
    call void @print_int(i32 %_13)
    %_14 = load i32, i32* %p6
    call void @print_int(i32 %_14)
    %_15 = bitcast i8* %this to i8***
    %_16 = load i8**, i8*** %_15
    %_17 = getelementptr i8*, i8** %_16, i32 1
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i32 (i8*, i32, i32, i32, i32, i32, i32)*
    %_20 = load i32, i32* %p6
    %_21 = load i32, i32* %p5
    %_22 = load i32, i32* %p4
    %_23 = load i32, i32* %p3
    %_24 = load i32, i32* %p2
    %_25 = load i32, i32* %p1
    %_26 = call i32 %_19(i8* %this, i32 %_20, i32 %_21, i32 %_22, i32 %_23, i32 %_24, i32 %_25)
    store i32 %_26, i32* %aux

    %_27 = load i32, i32* %aux
    ret i32 %_27
}

define i32 @MT4.Change(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
    %p1 = alloca i32
    store i32 %.p1, i32* %p1

    %p2 = alloca i32
    store i32 %.p2, i32* %p2

    %p3 = alloca i32
    store i32 %.p3, i32* %p3

    %p4 = alloca i32
    store i32 %.p4, i32* %p4

    %p5 = alloca i32
    store i32 %.p5, i32* %p5

    %p6 = alloca i32
    store i32 %.p6, i32* %p6

    %_28 = load i32, i32* %p1
    call void @print_int(i32 %_28)
    %_29 = load i32, i32* %p2
    call void @print_int(i32 %_29)
    %_30 = load i32, i32* %p3
    call void @print_int(i32 %_30)
    %_31 = load i32, i32* %p4
    call void @print_int(i32 %_31)
    %_32 = load i32, i32* %p5
    call void @print_int(i32 %_32)
    %_33 = load i32, i32* %p6
    call void @print_int(i32 %_33)
    ret i32 0
}
