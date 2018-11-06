@.FunsAsParams_vtable = global [0 x i8*] []
@.A_vtable = global [5 x i8*] [i8* bitcast (i1 (i8*, i32)* @A.set to i8*), i8* bitcast (i32 (i8*)* @A.get to i8*), i8* bitcast (i32 (i8*, i32, i32)* @A.add to i8*), i8* bitcast (i32 (i8*, i8*, i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*, i32, i32)* @A.bar to i8*)]
@.B_vtable = global [5 x i8*] [i8* bitcast (i1 (i8*, i32)* @A.set to i8*), i8* bitcast (i32 (i8*)* @A.get to i8*), i8* bitcast (i32 (i8*, i32, i32)* @A.add to i8*), i8* bitcast (i32 (i8*, i8*, i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*, i32, i32)* @A.bar to i8*)]

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
    %objA = alloca i8*

    %objB = alloca i8*

    %call = alloca i1

    %_0 = call i8* @calloc(i32 1, i32 12)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [5 x i8*], [5 x i8*]* @.A_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    store i8* %_0, i8** %objA

    %_3 = load i8*, i8** %objA
    %_4 = bitcast i8* %_3 to i8***
    %_5 = load i8**, i8*** %_4
    %_6 = getelementptr i8*, i8** %_5, i32 0
    %_7 = load i8*, i8** %_6
    %_8 = bitcast i8* %_7 to i1 (i8*, i32)*
    %_9 = call i1 %_8(i8* %_3, i32 1)
    store i1 %_9, i1* %call

    %_10 = call i8* @calloc(i32 1, i32 12)
    %_11 = bitcast i8* %_10 to i8***
    %_12 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_12, i8*** %_11
    store i8* %_10, i8** %objB

    %_13 = load i8*, i8** %objB
    %_14 = bitcast i8* %_13 to i8***
    %_15 = load i8**, i8*** %_14
    %_16 = getelementptr i8*, i8** %_15, i32 0
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i1 (i8*, i32)*
    %_19 = call i1 %_18(i8* %_13, i32 2)
    store i1 %_19, i1* %call

    %_20 = load i8*, i8** %objA
    %_21 = bitcast i8* %_20 to i8***
    %_22 = load i8**, i8*** %_21
    %_23 = getelementptr i8*, i8** %_22, i32 3
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i32 (i8*, i8*, i8*)*
    %_26 = load i8*, i8** %objA
    %_27 = load i8*, i8** %objB
    %_28 = call i32 %_25(i8* %_20, i8* %_26, i8* %_27)
    call void @print_int(i32 %_28)
    %_29 = load i8*, i8** %objA
    %_30 = bitcast i8* %_29 to i8***
    %_31 = load i8**, i8*** %_30
    %_32 = getelementptr i8*, i8** %_31, i32 4
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i32 (i8*, i32, i32)*
    %_35 = load i8*, i8** %objA
    %_36 = bitcast i8* %_35 to i8***
    %_37 = load i8**, i8*** %_36
    %_38 = getelementptr i8*, i8** %_37, i32 2
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i32 (i8*, i32, i32)*
    %_41 = load i8*, i8** %objA
    %_42 = bitcast i8* %_41 to i8***
    %_43 = load i8**, i8*** %_42
    %_44 = getelementptr i8*, i8** %_43, i32 1
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i32 (i8*)*
    %_47 = call i32 %_46(i8* %_41)
    %_48 = load i8*, i8** %objB
    %_49 = bitcast i8* %_48 to i8***
    %_50 = load i8**, i8*** %_49
    %_51 = getelementptr i8*, i8** %_50, i32 1
    %_52 = load i8*, i8** %_51
    %_53 = bitcast i8* %_52 to i32 (i8*)*
    %_54 = call i32 %_53(i8* %_48)
    %_55 = call i32 %_40(i8* %_35, i32 %_47, i32 %_54)
    %_56 = load i8*, i8** %objA
    %_57 = bitcast i8* %_56 to i8***
    %_58 = load i8**, i8*** %_57
    %_59 = getelementptr i8*, i8** %_58, i32 2
    %_60 = load i8*, i8** %_59
    %_61 = bitcast i8* %_60 to i32 (i8*, i32, i32)*
    %_62 = load i8*, i8** %objB
    %_63 = bitcast i8* %_62 to i8***
    %_64 = load i8**, i8*** %_63
    %_65 = getelementptr i8*, i8** %_64, i32 2
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i32 (i8*, i32, i32)*
    %_68 = load i8*, i8** %objB
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = getelementptr i8*, i8** %_70, i32 2
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i32 (i8*, i32, i32)*
    %_74 = call i32 %_73(i8* %_68, i32 1, i32 1)
    %_75 = call i32 %_67(i8* %_62, i32 %_74, i32 1)
    %_76 = call i32 %_61(i8* %_56, i32 1, i32 %_75)
    %_77 = call i32 %_34(i8* %_29, i32 %_55, i32 %_76)
    call void @print_int(i32 %_77)
    ret i32 0
}

define i1 @A.set(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i

    %_78 = getelementptr i8, i8* %this, i32 8
    %_79 = bitcast i8* %_78 to i32*
    %_80 = load i32, i32* %i
    store i32 %_80, i32* %_79
    ret i1 1
}

define i32 @A.get(i8* %this) {
    %_81 = getelementptr i8, i8* %this, i32 8
    %_82 = bitcast i8* %_81 to i32*
    %_83 = load i32, i32* %_82
    ret i32 %_83
}

define i32 @A.add(i8* %this, i32 %.l, i32 %.r) {
    %l = alloca i32
    store i32 %.l, i32* %l

    %r = alloca i32
    store i32 %.r, i32* %r

    %_85 = load i32, i32* %l
    %_86 = load i32, i32* %r
    %_84 = add i32 %_85, %_86
    ret i32 %_84
}

define i32 @A.foo(i8* %this, i8* %.a1, i8* %.a2) {
    %a1 = alloca i8*
    store i8* %.a1, i8** %a1

    %a2 = alloca i8*
    store i8* %.a2, i8** %a2

    %_87 = load i8*, i8** %a1
    %_88 = bitcast i8* %_87 to i8***
    %_89 = load i8**, i8*** %_88
    %_90 = getelementptr i8*, i8** %_89, i32 1
    %_91 = load i8*, i8** %_90
    %_92 = bitcast i8* %_91 to i32 (i8*)*
    %_93 = call i32 %_92(i8* %_87)
    call void @print_int(i32 %_93)
    %_94 = load i8*, i8** %a2
    %_95 = bitcast i8* %_94 to i8***
    %_96 = load i8**, i8*** %_95
    %_97 = getelementptr i8*, i8** %_96, i32 1
    %_98 = load i8*, i8** %_97
    %_99 = bitcast i8* %_98 to i32 (i8*)*
    %_100 = call i32 %_99(i8* %_94)
    call void @print_int(i32 %_100)
    ret i32 111111111
}

define i32 @A.bar(i8* %this, i32 %.i1, i32 %.i2) {
    %i1 = alloca i32
    store i32 %.i1, i32* %i1

    %i2 = alloca i32
    store i32 %.i2, i32* %i2

    %_101 = load i32, i32* %i1
    call void @print_int(i32 %_101)
    %_102 = load i32, i32* %i2
    call void @print_int(i32 %_102)
    ret i32 222222222
}
