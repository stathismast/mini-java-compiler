@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)]

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
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = getelementptr i8*, i8** %_4, i32 0
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i32)*
    %_8 = call i32 %_7(i8* %_0, i32 10)
    call void @print_int(i32 %_8)
    ret i32 0
}

define i32 @LS.Start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz

    %aux01 = alloca i32

    %aux02 = alloca i32

    %_9 = bitcast i8* %this to i8***
    %_10 = load i8**, i8*** %_9
    %_11 = getelementptr i8*, i8** %_10, i32 3
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i32 (i8*, i32)*
    %_14 = load i32, i32* %sz
    %_15 = call i32 %_13(i8* %this, i32 %_14)
    store i32 %_15, i32* %aux01

    %_16 = bitcast i8* %this to i8***
    %_17 = load i8**, i8*** %_16
    %_18 = getelementptr i8*, i8** %_17, i32 1
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*)*
    %_21 = call i32 %_20(i8* %this)
    store i32 %_21, i32* %aux02

    call void @print_int(i32 9999)
    %_22 = bitcast i8* %this to i8***
    %_23 = load i8**, i8*** %_22
    %_24 = getelementptr i8*, i8** %_23, i32 2
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*, i32)*
    %_27 = call i32 %_26(i8* %this, i32 8)
    call void @print_int(i32 %_27)
    %_28 = bitcast i8* %this to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = getelementptr i8*, i8** %_29, i32 2
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32 (i8*, i32)*
    %_33 = call i32 %_32(i8* %this, i32 12)
    call void @print_int(i32 %_33)
    %_34 = bitcast i8* %this to i8***
    %_35 = load i8**, i8*** %_34
    %_36 = getelementptr i8*, i8** %_35, i32 2
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i32 (i8*, i32)*
    %_39 = call i32 %_38(i8* %this, i32 17)
    call void @print_int(i32 %_39)
    %_40 = bitcast i8* %this to i8***
    %_41 = load i8**, i8*** %_40
    %_42 = getelementptr i8*, i8** %_41, i32 2
    %_43 = load i8*, i8** %_42
    %_44 = bitcast i8* %_43 to i32 (i8*, i32)*
    %_45 = call i32 %_44(i8* %this, i32 50)
    call void @print_int(i32 %_45)
    ret i32 55
}

define i32 @LS.Print(i8* %this) {
    %j = alloca i32

    store i32 1, i32* %j

    br label %Label0
Label0:
    %_47 = load i32, i32* %j
    %_48 = getelementptr i8, i8* %this, i32 16
    %_49 = bitcast i8* %_48 to i32*
    %_50 = load i32, i32* %_49
    %_46 = icmp slt i32 %_47, %_50
    br i1 %_46, label %Label1, label %Label2
Label1:
    %_51 = getelementptr i8, i8* %this, i32 8
    %_52 = bitcast i8* %_51 to i32**
    %_53 = load i32*, i32** %_52
    %_54 = load i32, i32* %j
    %_55 = icmp slt i32 %_54, 0
    br i1 %_55, label %Label5, label %Label3

Label3:
    %_56 = getelementptr i32, i32* %_53, i32 0
    %_57 = load i32, i32* %_56
    %_58 = icmp slt i32 %_54, %_57
    br i1 %_58, label %Label4, label %Label5

Label4:
    %_59 = add i32 %_54, 1
    %_60 = getelementptr i32, i32* %_53, i32 %_59
    %_61 = load i32, i32* %_60
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    call void @print_int(i32 %_61)
    %_63 = load i32, i32* %j
    %_62 = add i32 %_63, 1
    store i32 %_62, i32* %j

    br label %Label0
Label2:

    ret i32 0
}

define i32 @LS.Search(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num

    %j = alloca i32

    %ls01 = alloca i1

    %ifound = alloca i32

    %aux01 = alloca i32

    %aux02 = alloca i32

    %nt = alloca i32

    store i32 1, i32* %j

    store i1 0, i1* %ls01

    store i32 0, i32* %ifound

    br label %Label7
Label7:
    %_65 = load i32, i32* %j
    %_66 = getelementptr i8, i8* %this, i32 16
    %_67 = bitcast i8* %_66 to i32*
    %_68 = load i32, i32* %_67
    %_64 = icmp slt i32 %_65, %_68
    br i1 %_64, label %Label8, label %Label9
Label8:
    %_69 = getelementptr i8, i8* %this, i32 8
    %_70 = bitcast i8* %_69 to i32**
    %_71 = load i32*, i32** %_70
    %_72 = load i32, i32* %j
    %_73 = icmp slt i32 %_72, 0
    br i1 %_73, label %Label12, label %Label10

Label10:
    %_74 = getelementptr i32, i32* %_71, i32 0
    %_75 = load i32, i32* %_74
    %_76 = icmp slt i32 %_72, %_75
    br i1 %_76, label %Label11, label %Label12

Label11:
    %_77 = add i32 %_72, 1
    %_78 = getelementptr i32, i32* %_71, i32 %_77
    %_79 = load i32, i32* %_78
    br label %Label13

Label12:
    call void @throw_oob()
    br label %Label13

Label13:
    store i32 %_79, i32* %aux01

    %_81 = load i32, i32* %num
    %_80 = add i32 %_81, 1
    store i32 %_80, i32* %aux02

    %_83 = load i32, i32* %aux01
    %_84 = load i32, i32* %num
    %_82 = icmp slt i32 %_83, %_84
    br i1 %_82, label %Label14, label %Label15
Label14:
    store i32 0, i32* %nt

    br label %Label16
Label15:
    %_87 = load i32, i32* %aux01
    %_88 = load i32, i32* %aux02
    %_86 = icmp slt i32 %_87, %_88
    %_85 = add i1 %_86, 1
    br i1 %_85, label %Label17, label %Label18
Label17:
    store i32 0, i32* %nt

    br label %Label19
Label18:
    store i1 1, i1* %ls01

    store i32 1, i32* %ifound

    %_89 = getelementptr i8, i8* %this, i32 16
    %_90 = bitcast i8* %_89 to i32*
    %_91 = load i32, i32* %_90
    store i32 %_91, i32* %j

    br label %Label19
Label19:

    br label %Label16
Label16:

    %_93 = load i32, i32* %j
    %_92 = add i32 %_93, 1
    store i32 %_92, i32* %j

    br label %Label7
Label9:

    %_94 = load i32, i32* %ifound
    ret i32 %_94
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz

    %j = alloca i32

    %k = alloca i32

    %aux01 = alloca i32

    %aux02 = alloca i32

    %_95 = getelementptr i8, i8* %this, i32 16
    %_96 = bitcast i8* %_95 to i32*
    %_97 = load i32, i32* %sz
    store i32 %_97, i32* %_96
    %_98 = getelementptr i8, i8* %this, i32 8
    %_99 = bitcast i8* %_98 to i32**
    %_100 = load i32, i32* %sz
    %_101 = add i32 %_100, 1
    %_102 = call i8* @calloc(i32 4, i32 %_101)
    %_103 = bitcast i8* %_102 to i32*
    store i32 %_100, i32* %_103
    store i32* %_103, i32** %_99
    store i32 1, i32* %j

    %_105 = getelementptr i8, i8* %this, i32 16
    %_106 = bitcast i8* %_105 to i32*
    %_107 = load i32, i32* %_106
    %_104 = add i32 %_107, 1
    store i32 %_104, i32* %k

    br label %Label20
Label20:
    %_109 = load i32, i32* %j
    %_110 = getelementptr i8, i8* %this, i32 16
    %_111 = bitcast i8* %_110 to i32*
    %_112 = load i32, i32* %_111
    %_108 = icmp slt i32 %_109, %_112
    br i1 %_108, label %Label21, label %Label22
Label21:
    %_114 = load i32, i32* %j
    %_113 = mul i32 2, %_114
    store i32 %_113, i32* %aux01

    %_116 = load i32, i32* %k
    %_115 = sub i32 %_116, 3
    store i32 %_115, i32* %aux02

    %_117 = getelementptr i8, i8* %this, i32 8
    %_118 = bitcast i8* %_117 to i32**
    %_119 = load i32*, i32** %_118
    %_120 = load i32, i32* %j
    %_122 = load i32, i32* %aux01
    %_123 = load i32, i32* %aux02
    %_121 = add i32 %_122, %_123
    %_124 = icmp slt i32 %_120, 0
    br i1 %_124, label %Label25, label %Label23

Label23:
    %_125 = getelementptr i32, i32* %_119, i32 0
    %_126 = load i32, i32* %_125
    %_127 = icmp slt i32 %_120, %_126
    br i1 %_127, label %Label24, label %Label25

Label24:
    %_128 = add i32 %_120, 1
    %_129 = getelementptr i32, i32* %_119, i32 %_128
    store i32 %_121, i32* %_129
    br label %Label26

Label25:
    call void @throw_oob()
    br label %Label26

Label26:
    %_132 = load i32, i32* %j
    %_131 = add i32 %_132, 1
    store i32 %_131, i32* %j

    %_134 = load i32, i32* %k
    %_133 = sub i32 %_134, 1
    store i32 %_133, i32* %k

    br label %Label20
Label22:

    ret i32 0
}
