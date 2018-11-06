@.test93_vtable = global [0 x i8*] []
@.Test_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i8* (i8*)* @Test.next to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 24)
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
    %_9 = getelementptr i8, i8* %this, i32 16
    %_10 = bitcast i8* %_9 to i32**
    %_11 = add i32 10, 1
    %_12 = call i8* @calloc(i32 4, i32 %_11)
    %_13 = bitcast i8* %_12 to i32*
    store i32 10, i32* %_13
    store i32* %_13, i32** %_10
    %_14 = getelementptr i8, i8* %this, i32 8
    %_15 = bitcast i8* %_14 to i8**
    %_16 = call i8* @calloc(i32 1, i32 24)
    %_17 = bitcast i8* %_16 to i8***
    %_18 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_18, i8*** %_17
    store i8* %_16, i8** %_15
    %_19 = getelementptr i8, i8* %this, i32 8
    %_20 = bitcast i8* %_19 to i8**
    %_21 = getelementptr i8, i8* %this, i32 8
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i8***
    %_25 = load i8**, i8*** %_24
    %_26 = getelementptr i8*, i8** %_25, i32 1
    %_27 = load i8*, i8** %_26
    %_28 = bitcast i8* %_27 to i8* (i8*)*
    %_29 = call i8* %_28(i8* %_23)
    %_30 = bitcast i8* %_29 to i8***
    %_31 = load i8**, i8*** %_30
    %_32 = getelementptr i8*, i8** %_31, i32 1
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i8* (i8*)*
    %_35 = call i8* %_34(i8* %_29)
    store i8* %_35, i8** %_20
    ret i32 0
}

define i8* @Test.next(i8* %this) {
    %_36 = getelementptr i8, i8* %this, i32 8
    %_37 = bitcast i8* %_36 to i8**
    %_38 = call i8* @calloc(i32 1, i32 24)
    %_39 = bitcast i8* %_38 to i8***
    %_40 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_40, i8*** %_39
    store i8* %_38, i8** %_37
    %_41 = getelementptr i8, i8* %this, i32 8
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    ret i8* %_43
}
