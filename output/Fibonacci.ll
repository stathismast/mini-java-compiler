@.Fibonacci_vtable = global [0 x i8*] []

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
    %x = alloca i32

    %y = alloca i32

    %z = alloca i32

    %counter = alloca i32

    %array = alloca i32*

    %size = alloca i32

    store i32 50, i32* %size

    %_0 = load i32, i32* %size
    %_1 = add i32 %_0, 1
    %_2 = call i8* @calloc(i32 4, i32 %_1)
    %_3 = bitcast i8* %_2 to i32*
    store i32 %_0, i32* %_3
    store i32* %_3, i32** %array

    store i32 0, i32* %x

    store i32 1, i32* %y

    store i32 0, i32* %counter

    br label %Label0
Label0:
    %_5 = load i32, i32* %x
    %_4 = icmp slt i32 %_5, 100000
    br i1 %_4, label %Label1, label %Label2
Label1:
    %_6 = load i32, i32* %x
    call void @print_int(i32 %_6)
    %_7 = load i32*, i32** %array
    %_8 = load i32, i32* %counter
    %_9 = load i32, i32* %x
    %_10 = icmp slt i32 %_8, 0
    br i1 %_10, label %Label5, label %Label3

Label3:
    %_11 = getelementptr i32, i32* %_7, i32 0
    %_12 = load i32, i32* %_11
    %_13 = icmp slt i32 %_8, %_12
    br i1 %_13, label %Label4, label %Label5

Label4:
    %_14 = add i32 %_8, 1
    %_15 = getelementptr i32, i32* %_7, i32 %_14
    store i32 %_9, i32* %_15
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    %_18 = load i32, i32* %counter
    %_17 = add i32 %_18, 1
    store i32 %_17, i32* %counter

    %_20 = load i32, i32* %x
    %_21 = load i32, i32* %y
    %_19 = add i32 %_20, %_21
    store i32 %_19, i32* %z

    %_22 = load i32, i32* %y
    store i32 %_22, i32* %x

    %_23 = load i32, i32* %z
    store i32 %_23, i32* %y

    br label %Label0
Label2:

    br label %Label7
Label7:
    %_24 = alloca i1
    %_26 = load i32, i32* %x
    %_25 = icmp slt i32 0, %_26
    br i1 %_25, label %Label11, label %Label12
Label11:
    %_30 = load i32, i32* %counter
    %_29 = icmp slt i32 0, %_30
    %_28 = add i1 %_29, 1
    %_27 = add i1 %_28, 1
    br i1 %_27, label %Label10, label %Label12
Label10:
    store i1 1 , i1* %_24
    br label %Label13
Label12:
    store i1 0 , i1* %_24
    br label %Label13
Label13:
    %_31 = load i1, i1* %_24
    br i1 %_31, label %Label8, label %Label9
Label8:
    %_32 = load i32*, i32** %array
    %_36 = load i32, i32* %counter
    %_35 = sub i32 %_36, 1
    %_34 = add i32 %_35, 50
    %_33 = sub i32 %_34, 50
    %_37 = icmp slt i32 %_33, 0
    br i1 %_37, label %Label16, label %Label14

Label14:
    %_38 = getelementptr i32, i32* %_32, i32 0
    %_39 = load i32, i32* %_38
    %_40 = icmp slt i32 %_33, %_39
    br i1 %_40, label %Label15, label %Label16

Label15:
    %_41 = add i32 %_33, 1
    %_42 = getelementptr i32, i32* %_32, i32 %_41
    %_43 = load i32, i32* %_42
    br label %Label17

Label16:
    call void @throw_oob()
    br label %Label17

Label17:
    call void @print_int(i32 %_43)
    %_45 = load i32, i32* %counter
    %_44 = sub i32 %_45, 1
    store i32 %_44, i32* %counter

    br label %Label7
Label9:

    ret i32 0
}
