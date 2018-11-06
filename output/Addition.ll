@.Addition_vtable = global [0 x i8*] []

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
    %w = alloca i32

    %x = alloca i32

    %y = alloca i32

    %z = alloca i32

    %b = alloca i1

    %b2 = alloca i1

    store i32 1, i32* %w

    store i32 10, i32* %x

    store i32 50, i32* %y

    store i32 100, i32* %z

    %_1 = load i32, i32* %x
    %_2 = load i32, i32* %y
    %_0 = icmp slt i32 %_1, %_2
    store i1 %_0, i1* %b

    %_4 = load i32, i32* %z
    %_5 = load i32, i32* %y
    %_3 = icmp slt i32 %_4, %_5
    store i1 %_3, i1* %b2

    %_7 = load i32, i32* %w
    %_9 = load i32, i32* %x
    %_11 = load i32, i32* %w
    %_10 = mul i32 %_11, 10
    %_8 = sub i32 %_9, %_10
    %_6 = icmp slt i32 %_7, %_8
    br i1 %_6, label %Label0, label %Label1
Label0:
    call void @print_int(i32 1)
    br label %Label2
Label1:
    %_12 = load i1, i1* %b
    br i1 %_12, label %Label3, label %Label4
Label3:
    %_13 = mul i32 2, 10
    call void @print_int(i32 %_13)
    br label %Label5
Label4:
    call void @print_int(i32 3)
    br label %Label5
Label5:

    br label %Label2
Label2:

    br i1 1, label %Label6, label %Label7
Label6:
    %_14 = load i1, i1* %b2
    br i1 %_14, label %Label9, label %Label10
Label9:
    call void @print_int(i32 4)
    br label %Label11
Label10:
    %_15 = load i32, i32* %x
    call void @print_int(i32 %_15)
    br label %Label11
Label11:

    br label %Label8
Label7:
    call void @print_int(i32 6)
    br label %Label8
Label8:

    br label %Label12
Label12:
    %_17 = load i32, i32* %w
    %_16 = icmp slt i32 %_17, 5
    br i1 %_16, label %Label13, label %Label14
Label13:
    %_19 = load i32, i32* %w
    %_18 = add i32 %_19, 1
    store i32 %_18, i32* %w

    %_20 = load i32, i32* %w
    call void @print_int(i32 %_20)
    br label %Label12
Label14:

    ret i32 0
}
