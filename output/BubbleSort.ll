@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @BBS.Start to i8*), i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), i8* bitcast (i32 (i8*)* @BBS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @BBS.Init to i8*)]

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
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
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

define i32 @BBS.Start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz

    %aux01 = alloca i32

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
    %_18 = getelementptr i8*, i8** %_17, i32 2
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*)*
    %_21 = call i32 %_20(i8* %this)
    store i32 %_21, i32* %aux01

    call void @print_int(i32 99999)
    %_22 = bitcast i8* %this to i8***
    %_23 = load i8**, i8*** %_22
    %_24 = getelementptr i8*, i8** %_23, i32 1
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*)*
    %_27 = call i32 %_26(i8* %this)
    store i32 %_27, i32* %aux01

    %_28 = bitcast i8* %this to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = getelementptr i8*, i8** %_29, i32 2
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32 (i8*)*
    %_33 = call i32 %_32(i8* %this)
    store i32 %_33, i32* %aux01

    ret i32 0
}

define i32 @BBS.Sort(i8* %this) {
    %nt = alloca i32

    %i = alloca i32

    %aux02 = alloca i32

    %aux04 = alloca i32

    %aux05 = alloca i32

    %aux06 = alloca i32

    %aux07 = alloca i32

    %j = alloca i32

    %t = alloca i32

    %_35 = getelementptr i8, i8* %this, i32 16
    %_36 = bitcast i8* %_35 to i32*
    %_37 = load i32, i32* %_36
    %_34 = sub i32 %_37, 1
    store i32 %_34, i32* %i

    %_38 = sub i32 0, 1
    store i32 %_38, i32* %aux02

    br label %Label0
Label0:
    %_40 = load i32, i32* %aux02
    %_41 = load i32, i32* %i
    %_39 = icmp slt i32 %_40, %_41
    br i1 %_39, label %Label1, label %Label2
Label1:
    store i32 1, i32* %j

    br label %Label3
Label3:
    %_43 = load i32, i32* %j
    %_45 = load i32, i32* %i
    %_44 = add i32 %_45, 1
    %_42 = icmp slt i32 %_43, %_44
    br i1 %_42, label %Label4, label %Label5
Label4:
    %_47 = load i32, i32* %j
    %_46 = sub i32 %_47, 1
    store i32 %_46, i32* %aux07

    %_48 = getelementptr i8, i8* %this, i32 8
    %_49 = bitcast i8* %_48 to i32**
    %_50 = load i32*, i32** %_49
    %_51 = load i32, i32* %aux07
    %_52 = icmp slt i32 %_51, 0
    br i1 %_52, label %Label8, label %Label6

Label6:
    %_53 = getelementptr i32, i32* %_50, i32 0
    %_54 = load i32, i32* %_53
    %_55 = icmp slt i32 %_51, %_54
    br i1 %_55, label %Label7, label %Label8

Label7:
    %_56 = add i32 %_51, 1
    %_57 = getelementptr i32, i32* %_50, i32 %_56
    %_58 = load i32, i32* %_57
    br label %Label9

Label8:
    call void @throw_oob()
    br label %Label9

Label9:
    store i32 %_58, i32* %aux04

    %_59 = getelementptr i8, i8* %this, i32 8
    %_60 = bitcast i8* %_59 to i32**
    %_61 = load i32*, i32** %_60
    %_62 = load i32, i32* %j
    %_63 = icmp slt i32 %_62, 0
    br i1 %_63, label %Label12, label %Label10

Label10:
    %_64 = getelementptr i32, i32* %_61, i32 0
    %_65 = load i32, i32* %_64
    %_66 = icmp slt i32 %_62, %_65
    br i1 %_66, label %Label11, label %Label12

Label11:
    %_67 = add i32 %_62, 1
    %_68 = getelementptr i32, i32* %_61, i32 %_67
    %_69 = load i32, i32* %_68
    br label %Label13

Label12:
    call void @throw_oob()
    br label %Label13

Label13:
    store i32 %_69, i32* %aux05

    %_71 = load i32, i32* %aux05
    %_72 = load i32, i32* %aux04
    %_70 = icmp slt i32 %_71, %_72
    br i1 %_70, label %Label14, label %Label15
Label14:
    %_74 = load i32, i32* %j
    %_73 = sub i32 %_74, 1
    store i32 %_73, i32* %aux06

    %_75 = getelementptr i8, i8* %this, i32 8
    %_76 = bitcast i8* %_75 to i32**
    %_77 = load i32*, i32** %_76
    %_78 = load i32, i32* %aux06
    %_79 = icmp slt i32 %_78, 0
    br i1 %_79, label %Label19, label %Label17

Label17:
    %_80 = getelementptr i32, i32* %_77, i32 0
    %_81 = load i32, i32* %_80
    %_82 = icmp slt i32 %_78, %_81
    br i1 %_82, label %Label18, label %Label19

Label18:
    %_83 = add i32 %_78, 1
    %_84 = getelementptr i32, i32* %_77, i32 %_83
    %_85 = load i32, i32* %_84
    br label %Label20

Label19:
    call void @throw_oob()
    br label %Label20

Label20:
    store i32 %_85, i32* %t

    %_86 = getelementptr i8, i8* %this, i32 8
    %_87 = bitcast i8* %_86 to i32**
    %_88 = load i32*, i32** %_87
    %_89 = load i32, i32* %aux06
    %_90 = getelementptr i8, i8* %this, i32 8
    %_91 = bitcast i8* %_90 to i32**
    %_92 = load i32*, i32** %_91
    %_93 = load i32, i32* %j
    %_94 = icmp slt i32 %_93, 0
    br i1 %_94, label %Label23, label %Label21

Label21:
    %_95 = getelementptr i32, i32* %_92, i32 0
    %_96 = load i32, i32* %_95
    %_97 = icmp slt i32 %_93, %_96
    br i1 %_97, label %Label22, label %Label23

Label22:
    %_98 = add i32 %_93, 1
    %_99 = getelementptr i32, i32* %_92, i32 %_98
    %_100 = load i32, i32* %_99
    br label %Label24

Label23:
    call void @throw_oob()
    br label %Label24

Label24:
    %_101 = icmp slt i32 %_89, 0
    br i1 %_101, label %Label27, label %Label25

Label25:
    %_102 = getelementptr i32, i32* %_88, i32 0
    %_103 = load i32, i32* %_102
    %_104 = icmp slt i32 %_89, %_103
    br i1 %_104, label %Label26, label %Label27

Label26:
    %_105 = add i32 %_89, 1
    %_106 = getelementptr i32, i32* %_88, i32 %_105
    store i32 %_100, i32* %_106
    br label %Label28

Label27:
    call void @throw_oob()
    br label %Label28

Label28:
    %_108 = getelementptr i8, i8* %this, i32 8
    %_109 = bitcast i8* %_108 to i32**
    %_110 = load i32*, i32** %_109
    %_111 = load i32, i32* %j
    %_112 = load i32, i32* %t
    %_113 = icmp slt i32 %_111, 0
    br i1 %_113, label %Label31, label %Label29

Label29:
    %_114 = getelementptr i32, i32* %_110, i32 0
    %_115 = load i32, i32* %_114
    %_116 = icmp slt i32 %_111, %_115
    br i1 %_116, label %Label30, label %Label31

Label30:
    %_117 = add i32 %_111, 1
    %_118 = getelementptr i32, i32* %_110, i32 %_117
    store i32 %_112, i32* %_118
    br label %Label32

Label31:
    call void @throw_oob()
    br label %Label32

Label32:
    br label %Label16
Label15:
    store i32 0, i32* %nt

    br label %Label16
Label16:

    %_121 = load i32, i32* %j
    %_120 = add i32 %_121, 1
    store i32 %_120, i32* %j

    br label %Label3
Label5:

    %_123 = load i32, i32* %i
    %_122 = sub i32 %_123, 1
    store i32 %_122, i32* %i

    br label %Label0
Label2:

    ret i32 0
}

define i32 @BBS.Print(i8* %this) {
    %j = alloca i32

    store i32 0, i32* %j

    br label %Label33
Label33:
    %_125 = load i32, i32* %j
    %_126 = getelementptr i8, i8* %this, i32 16
    %_127 = bitcast i8* %_126 to i32*
    %_128 = load i32, i32* %_127
    %_124 = icmp slt i32 %_125, %_128
    br i1 %_124, label %Label34, label %Label35
Label34:
    %_129 = getelementptr i8, i8* %this, i32 8
    %_130 = bitcast i8* %_129 to i32**
    %_131 = load i32*, i32** %_130
    %_132 = load i32, i32* %j
    %_133 = icmp slt i32 %_132, 0
    br i1 %_133, label %Label38, label %Label36

Label36:
    %_134 = getelementptr i32, i32* %_131, i32 0
    %_135 = load i32, i32* %_134
    %_136 = icmp slt i32 %_132, %_135
    br i1 %_136, label %Label37, label %Label38

Label37:
    %_137 = add i32 %_132, 1
    %_138 = getelementptr i32, i32* %_131, i32 %_137
    %_139 = load i32, i32* %_138
    br label %Label39

Label38:
    call void @throw_oob()
    br label %Label39

Label39:
    call void @print_int(i32 %_139)
    %_141 = load i32, i32* %j
    %_140 = add i32 %_141, 1
    store i32 %_140, i32* %j

    br label %Label33
Label35:

    ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz

    %_142 = getelementptr i8, i8* %this, i32 16
    %_143 = bitcast i8* %_142 to i32*
    %_144 = load i32, i32* %sz
    store i32 %_144, i32* %_143
    %_145 = getelementptr i8, i8* %this, i32 8
    %_146 = bitcast i8* %_145 to i32**
    %_147 = load i32, i32* %sz
    %_148 = add i32 %_147, 1
    %_149 = call i8* @calloc(i32 4, i32 %_148)
    %_150 = bitcast i8* %_149 to i32*
    store i32 %_147, i32* %_150
    store i32* %_150, i32** %_146
    %_151 = getelementptr i8, i8* %this, i32 8
    %_152 = bitcast i8* %_151 to i32**
    %_153 = load i32*, i32** %_152
    %_154 = icmp slt i32 0, 0
    br i1 %_154, label %Label42, label %Label40

Label40:
    %_155 = getelementptr i32, i32* %_153, i32 0
    %_156 = load i32, i32* %_155
    %_157 = icmp slt i32 0, %_156
    br i1 %_157, label %Label41, label %Label42

Label41:
    %_158 = add i32 0, 1
    %_159 = getelementptr i32, i32* %_153, i32 %_158
    store i32 20, i32* %_159
    br label %Label43

Label42:
    call void @throw_oob()
    br label %Label43

Label43:
    %_161 = getelementptr i8, i8* %this, i32 8
    %_162 = bitcast i8* %_161 to i32**
    %_163 = load i32*, i32** %_162
    %_164 = icmp slt i32 1, 0
    br i1 %_164, label %Label46, label %Label44

Label44:
    %_165 = getelementptr i32, i32* %_163, i32 0
    %_166 = load i32, i32* %_165
    %_167 = icmp slt i32 1, %_166
    br i1 %_167, label %Label45, label %Label46

Label45:
    %_168 = add i32 1, 1
    %_169 = getelementptr i32, i32* %_163, i32 %_168
    store i32 7, i32* %_169
    br label %Label47

Label46:
    call void @throw_oob()
    br label %Label47

Label47:
    %_171 = getelementptr i8, i8* %this, i32 8
    %_172 = bitcast i8* %_171 to i32**
    %_173 = load i32*, i32** %_172
    %_174 = icmp slt i32 2, 0
    br i1 %_174, label %Label50, label %Label48

Label48:
    %_175 = getelementptr i32, i32* %_173, i32 0
    %_176 = load i32, i32* %_175
    %_177 = icmp slt i32 2, %_176
    br i1 %_177, label %Label49, label %Label50

Label49:
    %_178 = add i32 2, 1
    %_179 = getelementptr i32, i32* %_173, i32 %_178
    store i32 12, i32* %_179
    br label %Label51

Label50:
    call void @throw_oob()
    br label %Label51

Label51:
    %_181 = getelementptr i8, i8* %this, i32 8
    %_182 = bitcast i8* %_181 to i32**
    %_183 = load i32*, i32** %_182
    %_184 = icmp slt i32 3, 0
    br i1 %_184, label %Label54, label %Label52

Label52:
    %_185 = getelementptr i32, i32* %_183, i32 0
    %_186 = load i32, i32* %_185
    %_187 = icmp slt i32 3, %_186
    br i1 %_187, label %Label53, label %Label54

Label53:
    %_188 = add i32 3, 1
    %_189 = getelementptr i32, i32* %_183, i32 %_188
    store i32 18, i32* %_189
    br label %Label55

Label54:
    call void @throw_oob()
    br label %Label55

Label55:
    %_191 = getelementptr i8, i8* %this, i32 8
    %_192 = bitcast i8* %_191 to i32**
    %_193 = load i32*, i32** %_192
    %_194 = icmp slt i32 4, 0
    br i1 %_194, label %Label58, label %Label56

Label56:
    %_195 = getelementptr i32, i32* %_193, i32 0
    %_196 = load i32, i32* %_195
    %_197 = icmp slt i32 4, %_196
    br i1 %_197, label %Label57, label %Label58

Label57:
    %_198 = add i32 4, 1
    %_199 = getelementptr i32, i32* %_193, i32 %_198
    store i32 2, i32* %_199
    br label %Label59

Label58:
    call void @throw_oob()
    br label %Label59

Label59:
    %_201 = getelementptr i8, i8* %this, i32 8
    %_202 = bitcast i8* %_201 to i32**
    %_203 = load i32*, i32** %_202
    %_204 = icmp slt i32 5, 0
    br i1 %_204, label %Label62, label %Label60

Label60:
    %_205 = getelementptr i32, i32* %_203, i32 0
    %_206 = load i32, i32* %_205
    %_207 = icmp slt i32 5, %_206
    br i1 %_207, label %Label61, label %Label62

Label61:
    %_208 = add i32 5, 1
    %_209 = getelementptr i32, i32* %_203, i32 %_208
    store i32 11, i32* %_209
    br label %Label63

Label62:
    call void @throw_oob()
    br label %Label63

Label63:
    %_211 = getelementptr i8, i8* %this, i32 8
    %_212 = bitcast i8* %_211 to i32**
    %_213 = load i32*, i32** %_212
    %_214 = icmp slt i32 6, 0
    br i1 %_214, label %Label66, label %Label64

Label64:
    %_215 = getelementptr i32, i32* %_213, i32 0
    %_216 = load i32, i32* %_215
    %_217 = icmp slt i32 6, %_216
    br i1 %_217, label %Label65, label %Label66

Label65:
    %_218 = add i32 6, 1
    %_219 = getelementptr i32, i32* %_213, i32 %_218
    store i32 6, i32* %_219
    br label %Label67

Label66:
    call void @throw_oob()
    br label %Label67

Label67:
    %_221 = getelementptr i8, i8* %this, i32 8
    %_222 = bitcast i8* %_221 to i32**
    %_223 = load i32*, i32** %_222
    %_224 = icmp slt i32 7, 0
    br i1 %_224, label %Label70, label %Label68

Label68:
    %_225 = getelementptr i32, i32* %_223, i32 0
    %_226 = load i32, i32* %_225
    %_227 = icmp slt i32 7, %_226
    br i1 %_227, label %Label69, label %Label70

Label69:
    %_228 = add i32 7, 1
    %_229 = getelementptr i32, i32* %_223, i32 %_228
    store i32 9, i32* %_229
    br label %Label71

Label70:
    call void @throw_oob()
    br label %Label71

Label71:
    %_231 = getelementptr i8, i8* %this, i32 8
    %_232 = bitcast i8* %_231 to i32**
    %_233 = load i32*, i32** %_232
    %_234 = icmp slt i32 8, 0
    br i1 %_234, label %Label74, label %Label72

Label72:
    %_235 = getelementptr i32, i32* %_233, i32 0
    %_236 = load i32, i32* %_235
    %_237 = icmp slt i32 8, %_236
    br i1 %_237, label %Label73, label %Label74

Label73:
    %_238 = add i32 8, 1
    %_239 = getelementptr i32, i32* %_233, i32 %_238
    store i32 19, i32* %_239
    br label %Label75

Label74:
    call void @throw_oob()
    br label %Label75

Label75:
    %_241 = getelementptr i8, i8* %this, i32 8
    %_242 = bitcast i8* %_241 to i32**
    %_243 = load i32*, i32** %_242
    %_244 = icmp slt i32 9, 0
    br i1 %_244, label %Label78, label %Label76

Label76:
    %_245 = getelementptr i32, i32* %_243, i32 0
    %_246 = load i32, i32* %_245
    %_247 = icmp slt i32 9, %_246
    br i1 %_247, label %Label77, label %Label78

Label77:
    %_248 = add i32 9, 1
    %_249 = getelementptr i32, i32* %_243, i32 %_248
    store i32 5, i32* %_249
    br label %Label79

Label78:
    call void @throw_oob()
    br label %Label79

Label79:
    ret i32 0
}
