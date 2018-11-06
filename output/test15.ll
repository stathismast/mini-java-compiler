@.test15_vtable = global [0 x i8*] []
@.Test_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i32 (i8*)* @Test.mutual1 to i8*), i8* bitcast (i32 (i8*)* @Test.mutual2 to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 16)
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
    %_9 = getelementptr i8, i8* %this, i32 8
    %_10 = bitcast i8* %_9 to i32*
    store i32 4, i32* %_10
    %_11 = getelementptr i8, i8* %this, i32 12
    %_12 = bitcast i8* %_11 to i32*
    store i32 0, i32* %_12
    %_13 = bitcast i8* %this to i8***
    %_14 = load i8**, i8*** %_13
    %_15 = getelementptr i8*, i8** %_14, i32 1
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i32 (i8*)*
    %_18 = call i32 %_17(i8* %this)
    ret i32 %_18
}

define i32 @Test.mutual1(i8* %this) {
    %j = alloca i32

    %_19 = getelementptr i8, i8* %this, i32 8
    %_20 = bitcast i8* %_19 to i32*
    %_22 = getelementptr i8, i8* %this, i32 8
    %_23 = bitcast i8* %_22 to i32*
    %_24 = load i32, i32* %_23
    %_21 = sub i32 %_24, 1
    store i32 %_21, i32* %_20
    %_26 = getelementptr i8, i8* %this, i32 8
    %_27 = bitcast i8* %_26 to i32*
    %_28 = load i32, i32* %_27
    %_25 = icmp slt i32 %_28, 0
    br i1 %_25, label %Label0, label %Label1
Label0:
    %_29 = getelementptr i8, i8* %this, i32 12
    %_30 = bitcast i8* %_29 to i32*
    store i32 0, i32* %_30
    br label %Label2
Label1:
    %_31 = getelementptr i8, i8* %this, i32 12
    %_32 = bitcast i8* %_31 to i32*
    %_33 = load i32, i32* %_32
    call void @print_int(i32 %_33)
    %_34 = getelementptr i8, i8* %this, i32 12
    %_35 = bitcast i8* %_34 to i32*
    store i32 1, i32* %_35
    %_36 = bitcast i8* %this to i8***
    %_37 = load i8**, i8*** %_36
    %_38 = getelementptr i8*, i8** %_37, i32 2
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i32 (i8*)*
    %_41 = call i32 %_40(i8* %this)
    store i32 %_41, i32* %j

    br label %Label2
Label2:

    %_42 = getelementptr i8, i8* %this, i32 12
    %_43 = bitcast i8* %_42 to i32*
    %_44 = load i32, i32* %_43
    ret i32 %_44
}

define i32 @Test.mutual2(i8* %this) {
    %j = alloca i32

    %_45 = getelementptr i8, i8* %this, i32 8
    %_46 = bitcast i8* %_45 to i32*
    %_48 = getelementptr i8, i8* %this, i32 8
    %_49 = bitcast i8* %_48 to i32*
    %_50 = load i32, i32* %_49
    %_47 = sub i32 %_50, 1
    store i32 %_47, i32* %_46
    %_52 = getelementptr i8, i8* %this, i32 8
    %_53 = bitcast i8* %_52 to i32*
    %_54 = load i32, i32* %_53
    %_51 = icmp slt i32 %_54, 0
    br i1 %_51, label %Label3, label %Label4
Label3:
    %_55 = getelementptr i8, i8* %this, i32 12
    %_56 = bitcast i8* %_55 to i32*
    store i32 0, i32* %_56
    br label %Label5
Label4:
    %_57 = getelementptr i8, i8* %this, i32 12
    %_58 = bitcast i8* %_57 to i32*
    %_59 = load i32, i32* %_58
    call void @print_int(i32 %_59)
    %_60 = getelementptr i8, i8* %this, i32 12
    %_61 = bitcast i8* %_60 to i32*
    store i32 0, i32* %_61
    %_62 = bitcast i8* %this to i8***
    %_63 = load i8**, i8*** %_62
    %_64 = getelementptr i8*, i8** %_63, i32 1
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i32 (i8*)*
    %_67 = call i32 %_66(i8* %this)
    store i32 %_67, i32* %j

    br label %Label5
Label5:

    %_68 = getelementptr i8, i8* %this, i32 12
    %_69 = bitcast i8* %_68 to i32*
    %_70 = load i32, i32* %_69
    ret i32 %_70
}
