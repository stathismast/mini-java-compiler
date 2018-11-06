@.test82_vtable = global [0 x i8*] []
@.Test_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i1 (i8*)* @Test.next to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 17)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
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

define i32 @Test.start(i8* %this) {
    %_9 = getelementptr i8, i8* %this, i32 8
    %_10 = bitcast i8* %_9 to i8**
    %_11 = call i8* @calloc(i32 1, i32 17)
    %_12 = bitcast i8* %_11 to i8***
    %_13 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_13, i8*** %_12
    store i8* %_11, i8** %_10
    %_14 = getelementptr i8, i8* %this, i32 16
    %_15 = bitcast i8* %_14 to i1*
    %_16 = getelementptr i8, i8* %this, i32 8
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i8***
    %_20 = load i8**, i8*** %_19
    %_21 = getelementptr i8*, i8** %_20, i32 1
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i1 (i8*)*
    %_24 = call i1 %_23(i8* %_18)
    store i1 %_24, i1* %_15
    ret i32 0
}

define i1 @Test.next(i8* %this) {
    %b2 = alloca i1

    %_25 = alloca i1
    %_26 = alloca i1
    br i1 1, label %Label5, label %Label6
Label5:
    %_27 = icmp slt i32 7, 8
    br i1 %_27, label %Label4, label %Label6
Label4:
    store i1 1 , i1* %_26
    br label %Label7
Label6:
    store i1 0 , i1* %_26
    br label %Label7
Label7:
    %_28 = load i1, i1* %_26
    br i1 %_28, label %Label1, label %Label2
Label1:
    %_30 = getelementptr i8, i8* %this, i32 16
    %_31 = bitcast i8* %_30 to i1*
    %_32 = load i1, i1* %_31
    %_29 = add i1 %_32, 1
    br i1 %_29, label %Label0, label %Label2
Label0:
    store i1 1 , i1* %_25
    br label %Label3
Label2:
    store i1 0 , i1* %_25
    br label %Label3
Label3:
    %_33 = load i1, i1* %_25
    store i1 %_33, i1* %b2

    %_34 = load i1, i1* %b2
    ret i1 %_34
}
