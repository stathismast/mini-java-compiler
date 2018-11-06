@.test99_vtable = global [0 x i8*] []
@.Test_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i32 (i8*, i8*)* @Test.next to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 20)
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
    %_11 = call i8* @calloc(i32 1, i32 20)
    %_12 = bitcast i8* %_11 to i8***
    %_13 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
    store i8** %_13, i8*** %_12
    store i8* %_11, i8** %_10
    %_14 = getelementptr i8, i8* %this, i32 16
    %_15 = bitcast i8* %_14 to i32*
    %_16 = getelementptr i8, i8* %this, i32 8
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i8***
    %_20 = load i8**, i8*** %_19
    %_21 = getelementptr i8*, i8** %_20, i32 1
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i32 (i8*, i8*)*
    %_24 = call i32 %_23(i8* %_18, i8* %this)
    store i32 %_24, i32* %_15
    ret i32 0
}

define i32 @Test.next(i8* %this, i8* %.t) {
    %t = alloca i8*
    store i8* %.t, i8** %t

    ret i32 0
}
