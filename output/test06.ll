@.test06_vtable = global [0 x i8*] []
@.Operator_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @Operator.compute to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 19)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Operator_vtable, i32 0, i32 0
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

define i32 @Operator.compute(i8* %this) {
    %_9 = getelementptr i8, i8* %this, i32 8
    %_10 = bitcast i8* %_9 to i1*
    store i1 1, i1* %_10
    %_11 = getelementptr i8, i8* %this, i32 9
    %_12 = bitcast i8* %_11 to i1*
    store i1 0, i1* %_12
    %_13 = getelementptr i8, i8* %this, i32 18
    %_14 = bitcast i8* %_13 to i1*
    %_15 = alloca i1
    %_16 = getelementptr i8, i8* %this, i32 8
    %_17 = bitcast i8* %_16 to i1*
    %_18 = load i1, i1* %_17
    br i1 %_18, label %Label1, label %Label2
Label1:
    %_19 = getelementptr i8, i8* %this, i32 9
    %_20 = bitcast i8* %_19 to i1*
    %_21 = load i1, i1* %_20
    br i1 %_21, label %Label0, label %Label2
Label0:
    store i1 1 , i1* %_15
    br label %Label3
Label2:
    store i1 0 , i1* %_15
    br label %Label3
Label3:
    %_22 = load i1, i1* %_15
    store i1 %_22, i1* %_14
    ret i32 0
}
