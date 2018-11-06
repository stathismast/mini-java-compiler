@.Main_vtable = global [0 x i8*] []
@.B_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @B.test to i8*)]
@.ArrayTest_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @ArrayTest.test to i8*)]

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
    %ab = alloca i8*

    %_0 = call i8* @calloc(i32 1, i32 20)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    store i8* %_0, i8** %ab

    %_3 = load i8*, i8** %ab
    %_4 = bitcast i8* %_3 to i8***
    %_5 = load i8**, i8*** %_4
    %_6 = getelementptr i8*, i8** %_5, i32 0
    %_7 = load i8*, i8** %_6
    %_8 = bitcast i8* %_7 to i32 (i8*, i32)*
    %_9 = call i32 %_8(i8* %_3, i32 3)
    call void @print_int(i32 %_9)
    ret i32 0
}

define i32 @ArrayTest.test(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num

    %i = alloca i32

    %intArray = alloca i32*

    %_10 = load i32, i32* %num
    %_11 = add i32 %_10, 1
    %_12 = call i8* @calloc(i32 4, i32 %_11)
    %_13 = bitcast i8* %_12 to i32*
    store i32 %_10, i32* %_13
    store i32* %_13, i32** %intArray

    %_14 = getelementptr i8, i8* %this, i32 16
    %_15 = bitcast i8* %_14 to i32*
    store i32 0, i32* %_15
    %_16 = getelementptr i8, i8* %this, i32 16
    %_17 = bitcast i8* %_16 to i32*
    %_18 = load i32, i32* %_17
    call void @print_int(i32 %_18)
    %_19 = load i32*, i32** %intArray
    %_20 = getelementptr i32, i32* %_19, i32 0
    %_21 = load i32, i32* %_20
    call void @print_int(i32 %_21)
    store i32 0, i32* %i

    call void @print_int(i32 111)
    br label %Label0
Label0:
    %_23 = load i32, i32* %i
    %_24 = load i32*, i32** %intArray
    %_25 = getelementptr i32, i32* %_24, i32 0
    %_26 = load i32, i32* %_25
    %_22 = icmp slt i32 %_23, %_26
    br i1 %_22, label %Label1, label %Label2
Label1:
    %_28 = load i32, i32* %i
    %_27 = add i32 %_28, 1
    call void @print_int(i32 %_27)
    %_29 = load i32*, i32** %intArray
    %_30 = load i32, i32* %i
    %_32 = load i32, i32* %i
    %_31 = add i32 %_32, 1
    %_33 = icmp slt i32 %_30, 0
    br i1 %_33, label %Label5, label %Label3

Label3:
    %_34 = getelementptr i32, i32* %_29, i32 0
    %_35 = load i32, i32* %_34
    %_36 = icmp slt i32 %_30, %_35
    br i1 %_36, label %Label4, label %Label5

Label4:
    %_37 = add i32 %_30, 1
    %_38 = getelementptr i32, i32* %_29, i32 %_37
    store i32 %_31, i32* %_38
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    %_41 = load i32, i32* %i
    %_40 = add i32 %_41, 1
    store i32 %_40, i32* %i

    br label %Label0
Label2:

    call void @print_int(i32 222)
    store i32 0, i32* %i

    br label %Label7
Label7:
    %_43 = load i32, i32* %i
    %_44 = load i32*, i32** %intArray
    %_45 = getelementptr i32, i32* %_44, i32 0
    %_46 = load i32, i32* %_45
    %_42 = icmp slt i32 %_43, %_46
    br i1 %_42, label %Label8, label %Label9
Label8:
    %_47 = load i32*, i32** %intArray
    %_48 = load i32, i32* %i
    %_49 = icmp slt i32 %_48, 0
    br i1 %_49, label %Label12, label %Label10

Label10:
    %_50 = getelementptr i32, i32* %_47, i32 0
    %_51 = load i32, i32* %_50
    %_52 = icmp slt i32 %_48, %_51
    br i1 %_52, label %Label11, label %Label12

Label11:
    %_53 = add i32 %_48, 1
    %_54 = getelementptr i32, i32* %_47, i32 %_53
    %_55 = load i32, i32* %_54
    br label %Label13

Label12:
    call void @throw_oob()
    br label %Label13

Label13:
    call void @print_int(i32 %_55)
    %_57 = load i32, i32* %i
    %_56 = add i32 %_57, 1
    store i32 %_56, i32* %i

    br label %Label7
Label9:

    call void @print_int(i32 333)
    %_58 = load i32*, i32** %intArray
    %_59 = getelementptr i32, i32* %_58, i32 0
    %_60 = load i32, i32* %_59
    ret i32 %_60
}

define i32 @B.test(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num

    %i = alloca i32

    %intArray = alloca i32*

    %_61 = load i32, i32* %num
    %_62 = add i32 %_61, 1
    %_63 = call i8* @calloc(i32 4, i32 %_62)
    %_64 = bitcast i8* %_63 to i32*
    store i32 %_61, i32* %_64
    store i32* %_64, i32** %intArray

    %_65 = getelementptr i8, i8* %this, i32 20
    %_66 = bitcast i8* %_65 to i32*
    store i32 12, i32* %_66
    %_67 = getelementptr i8, i8* %this, i32 20
    %_68 = bitcast i8* %_67 to i32*
    %_69 = load i32, i32* %_68
    call void @print_int(i32 %_69)
    %_70 = load i32*, i32** %intArray
    %_71 = getelementptr i32, i32* %_70, i32 0
    %_72 = load i32, i32* %_71
    call void @print_int(i32 %_72)
    store i32 0, i32* %i

    call void @print_int(i32 111)
    br label %Label14
Label14:
    %_74 = load i32, i32* %i
    %_75 = load i32*, i32** %intArray
    %_76 = getelementptr i32, i32* %_75, i32 0
    %_77 = load i32, i32* %_76
    %_73 = icmp slt i32 %_74, %_77
    br i1 %_73, label %Label15, label %Label16
Label15:
    %_79 = load i32, i32* %i
    %_78 = add i32 %_79, 1
    call void @print_int(i32 %_78)
    %_80 = load i32*, i32** %intArray
    %_81 = load i32, i32* %i
    %_83 = load i32, i32* %i
    %_82 = add i32 %_83, 1
    %_84 = icmp slt i32 %_81, 0
    br i1 %_84, label %Label19, label %Label17

Label17:
    %_85 = getelementptr i32, i32* %_80, i32 0
    %_86 = load i32, i32* %_85
    %_87 = icmp slt i32 %_81, %_86
    br i1 %_87, label %Label18, label %Label19

Label18:
    %_88 = add i32 %_81, 1
    %_89 = getelementptr i32, i32* %_80, i32 %_88
    store i32 %_82, i32* %_89
    br label %Label20

Label19:
    call void @throw_oob()
    br label %Label20

Label20:
    %_92 = load i32, i32* %i
    %_91 = add i32 %_92, 1
    store i32 %_91, i32* %i

    br label %Label14
Label16:

    call void @print_int(i32 222)
    store i32 0, i32* %i

    br label %Label21
Label21:
    %_94 = load i32, i32* %i
    %_95 = load i32*, i32** %intArray
    %_96 = getelementptr i32, i32* %_95, i32 0
    %_97 = load i32, i32* %_96
    %_93 = icmp slt i32 %_94, %_97
    br i1 %_93, label %Label22, label %Label23
Label22:
    %_98 = load i32*, i32** %intArray
    %_99 = load i32, i32* %i
    %_100 = icmp slt i32 %_99, 0
    br i1 %_100, label %Label26, label %Label24

Label24:
    %_101 = getelementptr i32, i32* %_98, i32 0
    %_102 = load i32, i32* %_101
    %_103 = icmp slt i32 %_99, %_102
    br i1 %_103, label %Label25, label %Label26

Label25:
    %_104 = add i32 %_99, 1
    %_105 = getelementptr i32, i32* %_98, i32 %_104
    %_106 = load i32, i32* %_105
    br label %Label27

Label26:
    call void @throw_oob()
    br label %Label27

Label27:
    call void @print_int(i32 %_106)
    %_108 = load i32, i32* %i
    %_107 = add i32 %_108, 1
    store i32 %_107, i32* %i

    br label %Label21
Label23:

    call void @print_int(i32 333)
    %_109 = load i32*, i32** %intArray
    %_110 = getelementptr i32, i32* %_109, i32 0
    %_111 = load i32, i32* %_110
    ret i32 %_111
}
