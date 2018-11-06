@.test17_vtable = global [0 x i8*] []
@.Test_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i8* (i8*, i8*)* @Test.first to i8*), i8* bitcast (i32 (i8*)* @Test.second to i8*)]

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
    %_2 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0
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
    %test = alloca i8*

    %_9 = call i8* @calloc(i32 1, i32 12)
    %_10 = bitcast i8* %_9 to i8***
    %_11 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_11, i8*** %_10
    store i8* %_9, i8** %test

    %_12 = getelementptr i8, i8* %this, i32 8
    %_13 = bitcast i8* %_12 to i32*
    store i32 10, i32* %_13
    %_14 = getelementptr i8, i8* %this, i32 8
    %_15 = bitcast i8* %_14 to i32*
    %_17 = getelementptr i8, i8* %this, i32 8
    %_18 = bitcast i8* %_17 to i32*
    %_19 = load i32, i32* %_18
    %_20 = load i8*, i8** %test
    %_21 = bitcast i8* %_20 to i8***
    %_22 = load i8**, i8*** %_21
    %_23 = getelementptr i8*, i8** %_22, i32 1
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i8* (i8*, i8*)*
    %_26 = call i8* %_25(i8* %_20, i8* %this)
    %_27 = bitcast i8* %_26 to i8***
    %_28 = load i8**, i8*** %_27
    %_29 = getelementptr i8*, i8** %_28, i32 2
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i32 (i8*)*
    %_32 = call i32 %_31(i8* %_26)
    %_16 = add i32 %_19, %_32
    store i32 %_16, i32* %_15
    %_33 = getelementptr i8, i8* %this, i32 8
    %_34 = bitcast i8* %_33 to i32*
    %_35 = load i32, i32* %_34
    ret i32 %_35
}

define i8* @Test.first(i8* %this, i8* %.test2) {
    %test2 = alloca i8*
    store i8* %.test2, i8** %test2

    %test3 = alloca i8*

    %_36 = load i8*, i8** %test2
    store i8* %_36, i8** %test3

    %_37 = load i8*, i8** %test3
    ret i8* %_37
}

define i32 @Test.second(i8* %this) {
    %_38 = getelementptr i8, i8* %this, i32 8
    %_39 = bitcast i8* %_38 to i32*
    %_41 = getelementptr i8, i8* %this, i32 8
    %_42 = bitcast i8* %_41 to i32*
    %_43 = load i32, i32* %_42
    %_40 = add i32 %_43, 10
    store i32 %_40, i32* %_39
    %_44 = getelementptr i8, i8* %this, i32 8
    %_45 = bitcast i8* %_44 to i32*
    %_46 = load i32, i32* %_45
    ret i32 %_46
}
