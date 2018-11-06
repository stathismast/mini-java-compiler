@.test20_vtable = global [0 x i8*] []
@.A23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @A23.init to i8*), i8* bitcast (i32 (i8*)* @A23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @A23.setI1 to i8*)]
@.B23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @B23.init to i8*), i8* bitcast (i32 (i8*)* @B23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @B23.setI1 to i8*)]
@.C23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @C23.init to i8*), i8* bitcast (i32 (i8*)* @C23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @C23.setI1 to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 36)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [3 x i8*], [3 x i8*]* @.C23_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i8*)*
    %_8 = call i8* @calloc(i32 1, i32 28)
    %_9 = bitcast i8* %_8 to i8***
    %_10 = getelementptr [3 x i8*], [3 x i8*]* @.B23_vtable, i32 0, i32 0
    store i8** %_10, i8*** %_9
    %_11 = call i32 %_7(i8* %_0, i8* %_8)
    call void @print_int(i32 %_11)
    ret i32 0
}

define i32 @A23.init(i8* %this, i8* %.a) {
    %a = alloca i8*
    store i8* %.a, i8** %a

    %_12 = getelementptr i8, i8* %this, i32 12
    %_13 = bitcast i8* %_12 to i32*
    %_14 = load i8*, i8** %a
    %_15 = bitcast i8* %_14 to i8***
    %_16 = load i8**, i8*** %_15
    %_17 = getelementptr i8*, i8** %_16, i32 1
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i32 (i8*)*
    %_20 = call i32 %_19(i8* %_14)
    store i32 %_20, i32* %_13
    %_21 = getelementptr i8, i8* %this, i32 16
    %_22 = bitcast i8* %_21 to i32*
    store i32 222, i32* %_22
    %_23 = getelementptr i8, i8* %this, i32 8
    %_24 = bitcast i8* %_23 to i32*
    %_25 = bitcast i8* %this to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = getelementptr i8*, i8** %_26, i32 2
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i32 (i8*, i32)*
    %_31 = getelementptr i8, i8* %this, i32 12
    %_32 = bitcast i8* %_31 to i32*
    %_33 = load i32, i32* %_32
    %_34 = getelementptr i8, i8* %this, i32 16
    %_35 = bitcast i8* %_34 to i32*
    %_36 = load i32, i32* %_35
    %_30 = add i32 %_33, %_36
    %_37 = call i32 %_29(i8* %this, i32 %_30)
    store i32 %_37, i32* %_24
    %_38 = getelementptr i8, i8* %this, i32 8
    %_39 = bitcast i8* %_38 to i32*
    %_40 = load i32, i32* %_39
    ret i32 %_40
}

define i32 @A23.getI1(i8* %this) {
    %_41 = getelementptr i8, i8* %this, i32 8
    %_42 = bitcast i8* %_41 to i32*
    %_43 = load i32, i32* %_42
    ret i32 %_43
}

define i32 @A23.setI1(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i

    %_44 = load i32, i32* %i
    ret i32 %_44
}

define i32 @B23.init(i8* %this, i8* %.a) {
    %a = alloca i8*
    store i8* %.a, i8** %a

    %a_local = alloca i8*

    %_45 = call i8* @calloc(i32 1, i32 20)
    %_46 = bitcast i8* %_45 to i8***
    %_47 = getelementptr [3 x i8*], [3 x i8*]* @.A23_vtable, i32 0, i32 0
    store i8** %_47, i8*** %_46
    store i8* %_45, i8** %a_local

    %_48 = getelementptr i8, i8* %this, i32 24
    %_49 = bitcast i8* %_48 to i32*
    %_50 = load i8*, i8** %a
    %_51 = bitcast i8* %_50 to i8***
    %_52 = load i8**, i8*** %_51
    %_53 = getelementptr i8*, i8** %_52, i32 1
    %_54 = load i8*, i8** %_53
    %_55 = bitcast i8* %_54 to i32 (i8*)*
    %_56 = call i32 %_55(i8* %_50)
    store i32 %_56, i32* %_49
    %_57 = getelementptr i8, i8* %this, i32 20
    %_58 = bitcast i8* %_57 to i32*
    %_59 = bitcast i8* %this to i8***
    %_60 = load i8**, i8*** %_59
    %_61 = getelementptr i8*, i8** %_60, i32 2
    %_62 = load i8*, i8** %_61
    %_63 = bitcast i8* %_62 to i32 (i8*, i32)*
    %_64 = getelementptr i8, i8* %this, i32 24
    %_65 = bitcast i8* %_64 to i32*
    %_66 = load i32, i32* %_65
    %_67 = call i32 %_63(i8* %this, i32 %_66)
    store i32 %_67, i32* %_58
    %_68 = load i8*, i8** %a_local
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = getelementptr i8*, i8** %_70, i32 0
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i32 (i8*, i8*)*
    %_74 = call i32 %_73(i8* %_68, i8* %this)
    ret i32 %_74
}

define i32 @B23.getI1(i8* %this) {
    %_75 = getelementptr i8, i8* %this, i32 20
    %_76 = bitcast i8* %_75 to i32*
    %_77 = load i32, i32* %_76
    ret i32 %_77
}

define i32 @B23.setI1(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i

    %_79 = load i32, i32* %i
    %_78 = add i32 %_79, 111
    ret i32 %_78
}

define i32 @C23.init(i8* %this, i8* %.a) {
    %a = alloca i8*
    store i8* %.a, i8** %a

    %_80 = getelementptr i8, i8* %this, i32 32
    %_81 = bitcast i8* %_80 to i32*
    store i32 333, i32* %_81
    %_82 = getelementptr i8, i8* %this, i32 28
    %_83 = bitcast i8* %_82 to i32*
    %_84 = bitcast i8* %this to i8***
    %_85 = load i8**, i8*** %_84
    %_86 = getelementptr i8*, i8** %_85, i32 2
    %_87 = load i8*, i8** %_86
    %_88 = bitcast i8* %_87 to i32 (i8*, i32)*
    %_89 = getelementptr i8, i8* %this, i32 32
    %_90 = bitcast i8* %_89 to i32*
    %_91 = load i32, i32* %_90
    %_92 = call i32 %_88(i8* %this, i32 %_91)
    store i32 %_92, i32* %_83
    %_93 = load i8*, i8** %a
    %_94 = bitcast i8* %_93 to i8***
    %_95 = load i8**, i8*** %_94
    %_96 = getelementptr i8*, i8** %_95, i32 0
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i32 (i8*, i8*)*
    %_99 = call i32 %_98(i8* %_93, i8* %this)
    ret i32 %_99
}

define i32 @C23.getI1(i8* %this) {
    %_100 = getelementptr i8, i8* %this, i32 28
    %_101 = bitcast i8* %_100 to i32*
    %_102 = load i32, i32* %_101
    ret i32 %_102
}

define i32 @C23.setI1(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i

    %_104 = load i32, i32* %i
    %_103 = mul i32 %_104, 2
    ret i32 %_103
}
