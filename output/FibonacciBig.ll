@.Fibonacci_vtable = global [0 x i8*] []
@.A_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*, i1, i32)* @A.foo to i8*), i8* bitcast (i32 (i8*, i32)* @A.bar to i8*)]
@.B_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i1, i32)* @B.foo to i8*), i8* bitcast (i32 (i8*, i32)* @B.bar to i8*), i8* bitcast (i32 (i8*, i1, i8*, i32*)* @B.barfoo to i8*), i8* bitcast (i32 (i8*)* @B.foobar to i8*)]

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
    %x = alloca i32

    %y = alloca i32

    %z = alloca i32

    %counter = alloca i32

    %array = alloca i32*

    %aaaa = alloca i8*

    %_0 = call i8* @calloc(i32 1, i32 29)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    store i8* %_0, i8** %aaaa

    %_3 = load i8*, i8** %aaaa
    %_4 = bitcast i8* %_3 to i8***
    %_5 = load i8**, i8*** %_4
    %_6 = getelementptr i8*, i8** %_5, i32 0
    %_7 = load i8*, i8** %_6
    %_8 = bitcast i8* %_7 to i32 (i8*, i1, i32)*
    %_9 = call i32 %_8(i8* %_3, i1 1, i32 2)
    store i32 %_9, i32* %x

    %_10 = load i32, i32* %x
    call void @print_int(i32 %_10)
    %_11 = call i8* @calloc(i32 1, i32 29)
    %_12 = bitcast i8* %_11 to i8***
    %_13 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_13, i8*** %_12
    %_14 = bitcast i8* %_11 to i8***
    %_15 = load i8**, i8*** %_14
    %_16 = getelementptr i8*, i8** %_15, i32 3
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i32 (i8*)*
    %_19 = call i32 %_18(i8* %_11)
    store i32 %_19, i32* %x

    %_20 = load i8*, i8** %aaaa
    %_21 = bitcast i8* %_20 to i8***
    %_22 = load i8**, i8*** %_21
    %_23 = getelementptr i8*, i8** %_22, i32 1
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i32 (i8*, i32)*
    %_26 = call i32 %_25(i8* %_20, i32 666)
    store i32 %_26, i32* %x

    %_27 = call i8* @calloc(i32 1, i32 29)
    %_28 = bitcast i8* %_27 to i8***
    %_29 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_29, i8*** %_28
    %_30 = bitcast i8* %_27 to i8***
    %_31 = load i8**, i8*** %_30
    %_32 = getelementptr i8*, i8** %_31, i32 2
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i32 (i8*, i1, i8*, i32*)*
    %_35 = call i8* @calloc(i32 1, i32 29)
    %_36 = bitcast i8* %_35 to i8***
    %_37 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
    store i8** %_37, i8*** %_36
    %_38 = add i32 5, 1
    %_39 = call i8* @calloc(i32 4, i32 %_38)
    %_40 = bitcast i8* %_39 to i32*
    store i32 5, i32* %_40
    %_41 = call i32 %_34(i8* %_27, i1 1, i8* %_35, i32* %_40)
    store i32 %_41, i32* %x

    %_42 = add i32 10, 1
    %_43 = call i8* @calloc(i32 4, i32 %_42)
    %_44 = bitcast i8* %_43 to i32*
    store i32 10, i32* %_44
    store i32* %_44, i32** %array

    store i32 0, i32* %x

    br label %Label0
Label0:
    %_46 = load i32, i32* %x
    %_45 = icmp slt i32 %_46, 10
    br i1 %_45, label %Label1, label %Label2
Label1:
    %_47 = load i32*, i32** %array
    %_48 = load i32, i32* %x
    %_49 = load i32, i32* %x
    %_50 = icmp slt i32 %_48, 0
    br i1 %_50, label %Label5, label %Label3

Label3:
    %_51 = getelementptr i32, i32* %_47, i32 0
    %_52 = load i32, i32* %_51
    %_53 = icmp slt i32 %_48, %_52
    br i1 %_53, label %Label4, label %Label5

Label4:
    %_54 = add i32 %_48, 1
    %_55 = getelementptr i32, i32* %_47, i32 %_54
    store i32 %_49, i32* %_55
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    %_58 = load i32, i32* %x
    %_57 = add i32 %_58, 1
    store i32 %_57, i32* %x

    br label %Label0
Label2:

    %_59 = load i32*, i32** %array
    %_60 = getelementptr i32, i32* %_59, i32 0
    %_61 = load i32, i32* %_60
    call void @print_int(i32 %_61)
    %_62 = load i32*, i32** %array
    %_63 = icmp slt i32 0, 0
    br i1 %_63, label %Label9, label %Label7

Label7:
    %_64 = getelementptr i32, i32* %_62, i32 0
    %_65 = load i32, i32* %_64
    %_66 = icmp slt i32 0, %_65
    br i1 %_66, label %Label8, label %Label9

Label8:
    %_67 = add i32 0, 1
    %_68 = getelementptr i32, i32* %_62, i32 %_67
    %_69 = load i32, i32* %_68
    br label %Label10

Label9:
    call void @throw_oob()
    br label %Label10

Label10:
    call void @print_int(i32 %_69)
    %_70 = load i32*, i32** %array
    %_71 = icmp slt i32 1, 0
    br i1 %_71, label %Label13, label %Label11

Label11:
    %_72 = getelementptr i32, i32* %_70, i32 0
    %_73 = load i32, i32* %_72
    %_74 = icmp slt i32 1, %_73
    br i1 %_74, label %Label12, label %Label13

Label12:
    %_75 = add i32 1, 1
    %_76 = getelementptr i32, i32* %_70, i32 %_75
    %_77 = load i32, i32* %_76
    br label %Label14

Label13:
    call void @throw_oob()
    br label %Label14

Label14:
    call void @print_int(i32 %_77)
    %_78 = load i32*, i32** %array
    %_79 = icmp slt i32 3, 0
    br i1 %_79, label %Label17, label %Label15

Label15:
    %_80 = getelementptr i32, i32* %_78, i32 0
    %_81 = load i32, i32* %_80
    %_82 = icmp slt i32 3, %_81
    br i1 %_82, label %Label16, label %Label17

Label16:
    %_83 = add i32 3, 1
    %_84 = getelementptr i32, i32* %_78, i32 %_83
    %_85 = load i32, i32* %_84
    br label %Label18

Label17:
    call void @throw_oob()
    br label %Label18

Label18:
    call void @print_int(i32 %_85)
    %_86 = load i32*, i32** %array
    %_87 = icmp slt i32 4, 0
    br i1 %_87, label %Label21, label %Label19

Label19:
    %_88 = getelementptr i32, i32* %_86, i32 0
    %_89 = load i32, i32* %_88
    %_90 = icmp slt i32 4, %_89
    br i1 %_90, label %Label20, label %Label21

Label20:
    %_91 = add i32 4, 1
    %_92 = getelementptr i32, i32* %_86, i32 %_91
    %_93 = load i32, i32* %_92
    br label %Label22

Label21:
    call void @throw_oob()
    br label %Label22

Label22:
    call void @print_int(i32 %_93)
    %_94 = load i32*, i32** %array
    %_95 = icmp slt i32 5, 0
    br i1 %_95, label %Label25, label %Label23

Label23:
    %_96 = getelementptr i32, i32* %_94, i32 0
    %_97 = load i32, i32* %_96
    %_98 = icmp slt i32 5, %_97
    br i1 %_98, label %Label24, label %Label25

Label24:
    %_99 = add i32 5, 1
    %_100 = getelementptr i32, i32* %_94, i32 %_99
    %_101 = load i32, i32* %_100
    br label %Label26

Label25:
    call void @throw_oob()
    br label %Label26

Label26:
    call void @print_int(i32 %_101)
    %_102 = load i32*, i32** %array
    %_103 = icmp slt i32 6, 0
    br i1 %_103, label %Label29, label %Label27

Label27:
    %_104 = getelementptr i32, i32* %_102, i32 0
    %_105 = load i32, i32* %_104
    %_106 = icmp slt i32 6, %_105
    br i1 %_106, label %Label28, label %Label29

Label28:
    %_107 = add i32 6, 1
    %_108 = getelementptr i32, i32* %_102, i32 %_107
    %_109 = load i32, i32* %_108
    br label %Label30

Label29:
    call void @throw_oob()
    br label %Label30

Label30:
    call void @print_int(i32 %_109)
    %_110 = load i32*, i32** %array
    %_111 = icmp slt i32 7, 0
    br i1 %_111, label %Label33, label %Label31

Label31:
    %_112 = getelementptr i32, i32* %_110, i32 0
    %_113 = load i32, i32* %_112
    %_114 = icmp slt i32 7, %_113
    br i1 %_114, label %Label32, label %Label33

Label32:
    %_115 = add i32 7, 1
    %_116 = getelementptr i32, i32* %_110, i32 %_115
    %_117 = load i32, i32* %_116
    br label %Label34

Label33:
    call void @throw_oob()
    br label %Label34

Label34:
    call void @print_int(i32 %_117)
    %_118 = load i32*, i32** %array
    %_119 = icmp slt i32 8, 0
    br i1 %_119, label %Label37, label %Label35

Label35:
    %_120 = getelementptr i32, i32* %_118, i32 0
    %_121 = load i32, i32* %_120
    %_122 = icmp slt i32 8, %_121
    br i1 %_122, label %Label36, label %Label37

Label36:
    %_123 = add i32 8, 1
    %_124 = getelementptr i32, i32* %_118, i32 %_123
    %_125 = load i32, i32* %_124
    br label %Label38

Label37:
    call void @throw_oob()
    br label %Label38

Label38:
    call void @print_int(i32 %_125)
    %_126 = load i32*, i32** %array
    %_128 = load i32*, i32** %array
    %_129 = getelementptr i32, i32* %_128, i32 0
    %_130 = load i32, i32* %_129
    %_127 = sub i32 %_130, 1
    %_131 = icmp slt i32 %_127, 0
    br i1 %_131, label %Label41, label %Label39

Label39:
    %_132 = getelementptr i32, i32* %_126, i32 0
    %_133 = load i32, i32* %_132
    %_134 = icmp slt i32 %_127, %_133
    br i1 %_134, label %Label40, label %Label41

Label40:
    %_135 = add i32 %_127, 1
    %_136 = getelementptr i32, i32* %_126, i32 %_135
    %_137 = load i32, i32* %_136
    br label %Label42

Label41:
    call void @throw_oob()
    br label %Label42

Label42:
    call void @print_int(i32 %_137)
    call void @print_int(i32 11111111)
    %_138 = add i32 50, 1
    %_139 = call i8* @calloc(i32 4, i32 %_138)
    %_140 = bitcast i8* %_139 to i32*
    store i32 50, i32* %_140
    store i32* %_140, i32** %array

    store i32 0, i32* %x

    store i32 1, i32* %y

    store i32 0, i32* %counter

    br label %Label43
Label43:
    %_142 = load i32, i32* %x
    %_141 = icmp slt i32 %_142, 1000
    br i1 %_141, label %Label44, label %Label45
Label44:
    %_143 = load i32, i32* %x
    call void @print_int(i32 %_143)
    %_144 = load i32*, i32** %array
    %_145 = load i32, i32* %counter
    %_146 = load i32, i32* %x
    %_147 = icmp slt i32 %_145, 0
    br i1 %_147, label %Label48, label %Label46

Label46:
    %_148 = getelementptr i32, i32* %_144, i32 0
    %_149 = load i32, i32* %_148
    %_150 = icmp slt i32 %_145, %_149
    br i1 %_150, label %Label47, label %Label48

Label47:
    %_151 = add i32 %_145, 1
    %_152 = getelementptr i32, i32* %_144, i32 %_151
    store i32 %_146, i32* %_152
    br label %Label49

Label48:
    call void @throw_oob()
    br label %Label49

Label49:
    %_155 = load i32, i32* %counter
    %_154 = add i32 %_155, 1
    store i32 %_154, i32* %counter

    %_157 = load i32, i32* %x
    %_158 = load i32, i32* %y
    %_156 = add i32 %_157, %_158
    store i32 %_156, i32* %z

    %_159 = load i32, i32* %y
    store i32 %_159, i32* %x

    %_160 = load i32, i32* %z
    store i32 %_160, i32* %y

    br label %Label43
Label45:

    br label %Label50
Label50:
    %_161 = alloca i1
    %_163 = load i32, i32* %x
    %_162 = icmp slt i32 0, %_163
    br i1 %_162, label %Label54, label %Label55
Label54:
    %_167 = load i32, i32* %counter
    %_166 = icmp slt i32 0, %_167
    %_165 = add i1 %_166, 1
    %_164 = add i1 %_165, 1
    br i1 %_164, label %Label53, label %Label55
Label53:
    store i1 1 , i1* %_161
    br label %Label56
Label55:
    store i1 0 , i1* %_161
    br label %Label56
Label56:
    %_168 = load i1, i1* %_161
    br i1 %_168, label %Label51, label %Label52
Label51:
    %_169 = load i32*, i32** %array
    %_173 = load i32, i32* %counter
    %_172 = sub i32 %_173, 1
    %_171 = add i32 %_172, 50
    %_170 = sub i32 %_171, 50
    %_174 = icmp slt i32 %_170, 0
    br i1 %_174, label %Label59, label %Label57

Label57:
    %_175 = getelementptr i32, i32* %_169, i32 0
    %_176 = load i32, i32* %_175
    %_177 = icmp slt i32 %_170, %_176
    br i1 %_177, label %Label58, label %Label59

Label58:
    %_178 = add i32 %_170, 1
    %_179 = getelementptr i32, i32* %_169, i32 %_178
    %_180 = load i32, i32* %_179
    br label %Label60

Label59:
    call void @throw_oob()
    br label %Label60

Label60:
    call void @print_int(i32 %_180)
    %_182 = load i32, i32* %counter
    %_181 = sub i32 %_182, 1
    store i32 %_181, i32* %counter

    br label %Label50
Label52:

    ret i32 0
}

define i32 @A.foo(i8* %this, i1 %.a, i32 %.aa) {
    %a = alloca i1
    store i1 %.a, i1* %a

    %aa = alloca i32
    store i32 %.aa, i32* %aa

    %x = alloca i32

    %_183 = getelementptr i8, i8* %this, i32 9
    %_184 = bitcast i8* %_183 to i32*
    store i32 666, i32* %_184
    %_185 = getelementptr i8, i8* %this, i32 21
    %_186 = bitcast i8* %_185 to i8**
    %_187 = call i8* @calloc(i32 1, i32 29)
    %_188 = bitcast i8* %_187 to i8***
    %_189 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_189, i8*** %_188
    store i8* %_187, i8** %_186
    %_190 = getelementptr i8, i8* %this, i32 8
    %_191 = bitcast i8* %_190 to i1*
    %_192 = load i1, i1* %_191
    br i1 %_192, label %Label61, label %Label62
Label61:
    call void @print_int(i32 1)
    br label %Label63
Label62:
    %_193 = getelementptr i8, i8* %this, i32 13
    %_194 = bitcast i8* %_193 to i32**
    %_195 = add i32 10, 1
    %_196 = call i8* @calloc(i32 4, i32 %_195)
    %_197 = bitcast i8* %_196 to i32*
    store i32 10, i32* %_197
    store i32* %_197, i32** %_194
    %_198 = getelementptr i8, i8* %this, i32 13
    %_199 = bitcast i8* %_198 to i32**
    %_200 = load i32*, i32** %_199
    %_201 = getelementptr i32, i32* %_200, i32 0
    %_202 = load i32, i32* %_201
    call void @print_int(i32 %_202)
    br label %Label63
Label63:

    %_203 = load i32, i32* %aa
    call void @print_int(i32 %_203)
    %_204 = load i1, i1* %a
    br i1 %_204, label %Label64, label %Label65
Label64:
    %_206 = load i32, i32* %aa
    %_205 = mul i32 2, %_206
    store i32 %_205, i32* %x

    br label %Label66
Label65:
    %_208 = load i32, i32* %aa
    %_207 = add i32 %_208, 7
    store i32 %_207, i32* %x

    br label %Label66
Label66:

    %_209 = load i32, i32* %x
    ret i32 %_209
}

define i32 @A.bar(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a

    %_210 = load i32, i32* %a
    call void @print_int(i32 %_210)
    %_211 = getelementptr i8, i8* %this, i32 9
    %_212 = bitcast i8* %_211 to i32*
    %_213 = load i32, i32* %_212
    call void @print_int(i32 %_213)
    %_214 = getelementptr i8, i8* %this, i32 13
    %_215 = bitcast i8* %_214 to i32**
    %_216 = add i32 5, 1
    %_217 = call i8* @calloc(i32 4, i32 %_216)
    %_218 = bitcast i8* %_217 to i32*
    store i32 5, i32* %_218
    store i32* %_218, i32** %_215
    %_219 = getelementptr i8, i8* %this, i32 13
    %_220 = bitcast i8* %_219 to i32**
    %_221 = load i32*, i32** %_220
    %_222 = icmp slt i32 2, 0
    br i1 %_222, label %Label69, label %Label67

Label67:
    %_223 = getelementptr i32, i32* %_221, i32 0
    %_224 = load i32, i32* %_223
    %_225 = icmp slt i32 2, %_224
    br i1 %_225, label %Label68, label %Label69

Label68:
    %_226 = add i32 2, 1
    %_227 = getelementptr i32, i32* %_221, i32 %_226
    store i32 666, i32* %_227
    br label %Label70

Label69:
    call void @throw_oob()
    br label %Label70

Label70:
    %_229 = getelementptr i8, i8* %this, i32 13
    %_230 = bitcast i8* %_229 to i32**
    %_231 = load i32*, i32** %_230
    %_232 = icmp slt i32 2, 0
    br i1 %_232, label %Label73, label %Label71

Label71:
    %_233 = getelementptr i32, i32* %_231, i32 0
    %_234 = load i32, i32* %_233
    %_235 = icmp slt i32 2, %_234
    br i1 %_235, label %Label72, label %Label73

Label72:
    %_236 = add i32 2, 1
    %_237 = getelementptr i32, i32* %_231, i32 %_236
    %_238 = load i32, i32* %_237
    br label %Label74

Label73:
    call void @throw_oob()
    br label %Label74

Label74:
    call void @print_int(i32 %_238)
    %_239 = getelementptr i8, i8* %this, i32 13
    %_240 = bitcast i8* %_239 to i32**
    %_241 = load i32*, i32** %_240
    %_242 = getelementptr i8, i8* %this, i32 21
    %_243 = bitcast i8* %_242 to i8**
    %_244 = load i8*, i8** %_243
    %_245 = bitcast i8* %_244 to i8***
    %_246 = load i8**, i8*** %_245
    %_247 = getelementptr i8*, i8** %_246, i32 3
    %_248 = load i8*, i8** %_247
    %_249 = bitcast i8* %_248 to i32 (i8*)*
    %_250 = call i32 %_249(i8* %_244)
    %_251 = icmp slt i32 0, 0
    br i1 %_251, label %Label77, label %Label75

Label75:
    %_252 = getelementptr i32, i32* %_241, i32 0
    %_253 = load i32, i32* %_252
    %_254 = icmp slt i32 0, %_253
    br i1 %_254, label %Label76, label %Label77

Label76:
    %_255 = add i32 0, 1
    %_256 = getelementptr i32, i32* %_241, i32 %_255
    store i32 %_250, i32* %_256
    br label %Label78

Label77:
    call void @throw_oob()
    br label %Label78

Label78:
    %_258 = getelementptr i8, i8* %this, i32 13
    %_259 = bitcast i8* %_258 to i32**
    %_260 = load i32*, i32** %_259
    %_261 = icmp slt i32 0, 0
    br i1 %_261, label %Label81, label %Label79

Label79:
    %_262 = getelementptr i32, i32* %_260, i32 0
    %_263 = load i32, i32* %_262
    %_264 = icmp slt i32 0, %_263
    br i1 %_264, label %Label80, label %Label81

Label80:
    %_265 = add i32 0, 1
    %_266 = getelementptr i32, i32* %_260, i32 %_265
    %_267 = load i32, i32* %_266
    br label %Label82

Label81:
    call void @throw_oob()
    br label %Label82

Label82:
    call void @print_int(i32 %_267)
    ret i32 0
}

define i32 @B.bar(i8* %this, i32 %.aa) {
    %aa = alloca i32
    store i32 %.aa, i32* %aa

    %x = alloca i32

    %_268 = load i32, i32* %aa
    store i32 %_268, i32* %x

    %_269 = load i32, i32* %x
    ret i32 %_269
}

define i32 @B.foo(i8* %this, i1 %.a, i32 %.aa) {
    %a = alloca i1
    store i1 %.a, i1* %a

    %aa = alloca i32
    store i32 %.aa, i32* %aa

    %x = alloca i32

    %_270 = getelementptr i8, i8* %this, i32 9
    %_271 = bitcast i8* %_270 to i32*
    store i32 666, i32* %_271
    %_272 = getelementptr i8, i8* %this, i32 21
    %_273 = bitcast i8* %_272 to i8**
    %_274 = call i8* @calloc(i32 1, i32 29)
    %_275 = bitcast i8* %_274 to i8***
    %_276 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_276, i8*** %_275
    store i8* %_274, i8** %_273
    %_277 = getelementptr i8, i8* %this, i32 8
    %_278 = bitcast i8* %_277 to i1*
    %_279 = load i1, i1* %_278
    br i1 %_279, label %Label83, label %Label84
Label83:
    call void @print_int(i32 1)
    br label %Label85
Label84:
    %_280 = getelementptr i8, i8* %this, i32 13
    %_281 = bitcast i8* %_280 to i32**
    %_282 = add i32 10, 1
    %_283 = call i8* @calloc(i32 4, i32 %_282)
    %_284 = bitcast i8* %_283 to i32*
    store i32 10, i32* %_284
    store i32* %_284, i32** %_281
    %_285 = getelementptr i8, i8* %this, i32 13
    %_286 = bitcast i8* %_285 to i32**
    %_287 = load i32*, i32** %_286
    %_288 = getelementptr i32, i32* %_287, i32 0
    %_289 = load i32, i32* %_288
    call void @print_int(i32 %_289)
    br label %Label85
Label85:

    %_290 = load i32, i32* %aa
    call void @print_int(i32 %_290)
    %_291 = load i1, i1* %a
    br i1 %_291, label %Label86, label %Label87
Label86:
    %_293 = load i32, i32* %aa
    %_292 = mul i32 2, %_293
    store i32 %_292, i32* %x

    br label %Label88
Label87:
    %_295 = load i32, i32* %aa
    %_294 = add i32 %_295, 7
    store i32 %_294, i32* %x

    br label %Label88
Label88:

    %_296 = load i32, i32* %x
    ret i32 %_296
}

define i32 @B.barfoo(i8* %this, i1 %.b, i8* %.bb, i32* %.bbb) {
    %b = alloca i1
    store i1 %.b, i1* %b

    %bb = alloca i8*
    store i8* %.bb, i8** %bb

    %bbb = alloca i32*
    store i32* %.bbb, i32** %bbb

    ret i32 0
}

define i32 @B.foobar(i8* %this) {
    call void @print_int(i32 1234567)
    ret i32 666
}
