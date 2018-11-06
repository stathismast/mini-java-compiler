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

    %fib = alloca i8*

    %aaaa = alloca i8*

    %_0 = call i8* @calloc(i32 1, i32 29)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
    store i8** %_2, i8*** %_1
    store i8* %_0, i8** %aaaa

    %_3 = call i8* @calloc(i32 1, i32 8)
    %_4 = bitcast i8* %_3 to i8***
    %_5 = getelementptr [0 x i8*], [0 x i8*]* @.Fibonacci_vtable, i32 0, i32 0
    store i8** %_5, i8*** %_4
    store i8* %_3, i8** %fib

    %_6 = add i32 10, 1
    %_7 = call i8* @calloc(i32 4, i32 %_6)
    %_8 = bitcast i8* %_7 to i32*
    store i32 10, i32* %_8
    store i32* %_8, i32** %array

    store i32 0, i32* %x

    br label %Label0
Label0:
    %_10 = load i32, i32* %x
    %_9 = icmp slt i32 %_10, 10
    br i1 %_9, label %Label1, label %Label2
Label1:
    %_11 = load i32*, i32** %array
    %_12 = load i32, i32* %x
    %_13 = load i32, i32* %x
    %_14 = icmp slt i32 %_12, 0
    br i1 %_14, label %Label5, label %Label3

Label3:
    %_15 = getelementptr i32, i32* %_11, i32 0
    %_16 = load i32, i32* %_15
    %_17 = icmp slt i32 %_12, %_16
    br i1 %_17, label %Label4, label %Label5

Label4:
    %_18 = add i32 %_12, 1
    %_19 = getelementptr i32, i32* %_11, i32 %_18
    store i32 %_13, i32* %_19
    br label %Label6

Label5:
    call void @throw_oob()
    br label %Label6

Label6:
    %_22 = load i32, i32* %x
    %_21 = add i32 %_22, 1
    store i32 %_21, i32* %x

    br label %Label0
Label2:

    %_23 = load i32*, i32** %array
    %_24 = getelementptr i32, i32* %_23, i32 0
    %_25 = load i32, i32* %_24
    call void @print_int(i32 %_25)
    %_26 = load i32*, i32** %array
    %_27 = icmp slt i32 0, 0
    br i1 %_27, label %Label9, label %Label7

Label7:
    %_28 = getelementptr i32, i32* %_26, i32 0
    %_29 = load i32, i32* %_28
    %_30 = icmp slt i32 0, %_29
    br i1 %_30, label %Label8, label %Label9

Label8:
    %_31 = add i32 0, 1
    %_32 = getelementptr i32, i32* %_26, i32 %_31
    %_33 = load i32, i32* %_32
    br label %Label10

Label9:
    call void @throw_oob()
    br label %Label10

Label10:
    call void @print_int(i32 %_33)
    %_34 = load i32*, i32** %array
    %_35 = icmp slt i32 1, 0
    br i1 %_35, label %Label13, label %Label11

Label11:
    %_36 = getelementptr i32, i32* %_34, i32 0
    %_37 = load i32, i32* %_36
    %_38 = icmp slt i32 1, %_37
    br i1 %_38, label %Label12, label %Label13

Label12:
    %_39 = add i32 1, 1
    %_40 = getelementptr i32, i32* %_34, i32 %_39
    %_41 = load i32, i32* %_40
    br label %Label14

Label13:
    call void @throw_oob()
    br label %Label14

Label14:
    call void @print_int(i32 %_41)
    %_42 = load i32*, i32** %array
    %_43 = icmp slt i32 3, 0
    br i1 %_43, label %Label17, label %Label15

Label15:
    %_44 = getelementptr i32, i32* %_42, i32 0
    %_45 = load i32, i32* %_44
    %_46 = icmp slt i32 3, %_45
    br i1 %_46, label %Label16, label %Label17

Label16:
    %_47 = add i32 3, 1
    %_48 = getelementptr i32, i32* %_42, i32 %_47
    %_49 = load i32, i32* %_48
    br label %Label18

Label17:
    call void @throw_oob()
    br label %Label18

Label18:
    call void @print_int(i32 %_49)
    %_50 = load i32*, i32** %array
    %_51 = icmp slt i32 4, 0
    br i1 %_51, label %Label21, label %Label19

Label19:
    %_52 = getelementptr i32, i32* %_50, i32 0
    %_53 = load i32, i32* %_52
    %_54 = icmp slt i32 4, %_53
    br i1 %_54, label %Label20, label %Label21

Label20:
    %_55 = add i32 4, 1
    %_56 = getelementptr i32, i32* %_50, i32 %_55
    %_57 = load i32, i32* %_56
    br label %Label22

Label21:
    call void @throw_oob()
    br label %Label22

Label22:
    call void @print_int(i32 %_57)
    %_58 = load i32*, i32** %array
    %_59 = icmp slt i32 5, 0
    br i1 %_59, label %Label25, label %Label23

Label23:
    %_60 = getelementptr i32, i32* %_58, i32 0
    %_61 = load i32, i32* %_60
    %_62 = icmp slt i32 5, %_61
    br i1 %_62, label %Label24, label %Label25

Label24:
    %_63 = add i32 5, 1
    %_64 = getelementptr i32, i32* %_58, i32 %_63
    %_65 = load i32, i32* %_64
    br label %Label26

Label25:
    call void @throw_oob()
    br label %Label26

Label26:
    call void @print_int(i32 %_65)
    %_66 = load i32*, i32** %array
    %_67 = icmp slt i32 6, 0
    br i1 %_67, label %Label29, label %Label27

Label27:
    %_68 = getelementptr i32, i32* %_66, i32 0
    %_69 = load i32, i32* %_68
    %_70 = icmp slt i32 6, %_69
    br i1 %_70, label %Label28, label %Label29

Label28:
    %_71 = add i32 6, 1
    %_72 = getelementptr i32, i32* %_66, i32 %_71
    %_73 = load i32, i32* %_72
    br label %Label30

Label29:
    call void @throw_oob()
    br label %Label30

Label30:
    call void @print_int(i32 %_73)
    %_74 = load i32*, i32** %array
    %_75 = icmp slt i32 7, 0
    br i1 %_75, label %Label33, label %Label31

Label31:
    %_76 = getelementptr i32, i32* %_74, i32 0
    %_77 = load i32, i32* %_76
    %_78 = icmp slt i32 7, %_77
    br i1 %_78, label %Label32, label %Label33

Label32:
    %_79 = add i32 7, 1
    %_80 = getelementptr i32, i32* %_74, i32 %_79
    %_81 = load i32, i32* %_80
    br label %Label34

Label33:
    call void @throw_oob()
    br label %Label34

Label34:
    call void @print_int(i32 %_81)
    %_82 = load i32*, i32** %array
    %_83 = icmp slt i32 8, 0
    br i1 %_83, label %Label37, label %Label35

Label35:
    %_84 = getelementptr i32, i32* %_82, i32 0
    %_85 = load i32, i32* %_84
    %_86 = icmp slt i32 8, %_85
    br i1 %_86, label %Label36, label %Label37

Label36:
    %_87 = add i32 8, 1
    %_88 = getelementptr i32, i32* %_82, i32 %_87
    %_89 = load i32, i32* %_88
    br label %Label38

Label37:
    call void @throw_oob()
    br label %Label38

Label38:
    call void @print_int(i32 %_89)
    %_90 = load i32*, i32** %array
    %_92 = load i32*, i32** %array
    %_93 = getelementptr i32, i32* %_92, i32 0
    %_94 = load i32, i32* %_93
    %_91 = sub i32 %_94, 1
    %_95 = icmp slt i32 %_91, 0
    br i1 %_95, label %Label41, label %Label39

Label39:
    %_96 = getelementptr i32, i32* %_90, i32 0
    %_97 = load i32, i32* %_96
    %_98 = icmp slt i32 %_91, %_97
    br i1 %_98, label %Label40, label %Label41

Label40:
    %_99 = add i32 %_91, 1
    %_100 = getelementptr i32, i32* %_90, i32 %_99
    %_101 = load i32, i32* %_100
    br label %Label42

Label41:
    call void @throw_oob()
    br label %Label42

Label42:
    call void @print_int(i32 %_101)
    call void @print_int(i32 11111111)
    %_102 = add i32 50, 1
    %_103 = call i8* @calloc(i32 4, i32 %_102)
    %_104 = bitcast i8* %_103 to i32*
    store i32 50, i32* %_104
    store i32* %_104, i32** %array

    store i32 0, i32* %x

    store i32 1, i32* %y

    store i32 0, i32* %counter

    br label %Label43
Label43:
    %_106 = load i32, i32* %x
    %_105 = icmp slt i32 %_106, 1000
    br i1 %_105, label %Label44, label %Label45
Label44:
    %_107 = load i32, i32* %x
    call void @print_int(i32 %_107)
    %_108 = load i32*, i32** %array
    %_109 = load i32, i32* %counter
    %_110 = load i32, i32* %x
    %_111 = icmp slt i32 %_109, 0
    br i1 %_111, label %Label48, label %Label46

Label46:
    %_112 = getelementptr i32, i32* %_108, i32 0
    %_113 = load i32, i32* %_112
    %_114 = icmp slt i32 %_109, %_113
    br i1 %_114, label %Label47, label %Label48

Label47:
    %_115 = add i32 %_109, 1
    %_116 = getelementptr i32, i32* %_108, i32 %_115
    store i32 %_110, i32* %_116
    br label %Label49

Label48:
    call void @throw_oob()
    br label %Label49

Label49:
    %_119 = load i32, i32* %counter
    %_118 = add i32 %_119, 1
    store i32 %_118, i32* %counter

    %_121 = load i32, i32* %x
    %_122 = load i32, i32* %y
    %_120 = add i32 %_121, %_122
    store i32 %_120, i32* %z

    %_123 = load i32, i32* %y
    store i32 %_123, i32* %x

    %_124 = load i32, i32* %z
    store i32 %_124, i32* %y

    br label %Label43
Label45:

    br label %Label50
Label50:
    %_125 = alloca i1
    %_127 = load i32, i32* %x
    %_126 = icmp slt i32 0, %_127
    br i1 %_126, label %Label54, label %Label55
Label54:
    %_131 = load i32, i32* %counter
    %_130 = icmp slt i32 0, %_131
    %_129 = add i1 %_130, 1
    %_128 = add i1 %_129, 1
    br i1 %_128, label %Label53, label %Label55
Label53:
    store i1 1 , i1* %_125
    br label %Label56
Label55:
    store i1 0 , i1* %_125
    br label %Label56
Label56:
    %_132 = load i1, i1* %_125
    br i1 %_132, label %Label51, label %Label52
Label51:
    %_133 = load i32*, i32** %array
    %_137 = load i32, i32* %counter
    %_136 = sub i32 %_137, 1
    %_135 = add i32 %_136, 50
    %_134 = sub i32 %_135, 50
    %_138 = icmp slt i32 %_134, 0
    br i1 %_138, label %Label59, label %Label57

Label57:
    %_139 = getelementptr i32, i32* %_133, i32 0
    %_140 = load i32, i32* %_139
    %_141 = icmp slt i32 %_134, %_140
    br i1 %_141, label %Label58, label %Label59

Label58:
    %_142 = add i32 %_134, 1
    %_143 = getelementptr i32, i32* %_133, i32 %_142
    %_144 = load i32, i32* %_143
    br label %Label60

Label59:
    call void @throw_oob()
    br label %Label60

Label60:
    call void @print_int(i32 %_144)
    %_146 = load i32, i32* %counter
    %_145 = sub i32 %_146, 1
    store i32 %_145, i32* %counter

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

    %_147 = getelementptr i8, i8* %this, i32 9
    %_148 = bitcast i8* %_147 to i32*
    store i32 666, i32* %_148
    %_149 = getelementptr i8, i8* %this, i32 21
    %_150 = bitcast i8* %_149 to i8**
    %_151 = call i8* @calloc(i32 1, i32 29)
    %_152 = bitcast i8* %_151 to i8***
    %_153 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_153, i8*** %_152
    store i8* %_151, i8** %_150
    %_154 = getelementptr i8, i8* %this, i32 8
    %_155 = bitcast i8* %_154 to i1*
    %_156 = load i1, i1* %_155
    br i1 %_156, label %Label61, label %Label62
Label61:
    call void @print_int(i32 1)
    br label %Label63
Label62:
    %_157 = getelementptr i8, i8* %this, i32 13
    %_158 = bitcast i8* %_157 to i32**
    %_159 = add i32 10, 1
    %_160 = call i8* @calloc(i32 4, i32 %_159)
    %_161 = bitcast i8* %_160 to i32*
    store i32 10, i32* %_161
    store i32* %_161, i32** %_158
    %_162 = getelementptr i8, i8* %this, i32 13
    %_163 = bitcast i8* %_162 to i32**
    %_164 = load i32*, i32** %_163
    %_165 = getelementptr i32, i32* %_164, i32 0
    %_166 = load i32, i32* %_165
    call void @print_int(i32 %_166)
    br label %Label63
Label63:

    %_167 = load i32, i32* %aa
    call void @print_int(i32 %_167)
    %_168 = load i1, i1* %a
    br i1 %_168, label %Label64, label %Label65
Label64:
    %_170 = load i32, i32* %aa
    %_169 = mul i32 2, %_170
    store i32 %_169, i32* %x

    br label %Label66
Label65:
    %_172 = load i32, i32* %aa
    %_171 = add i32 %_172, 7
    store i32 %_171, i32* %x

    br label %Label66
Label66:

    %_173 = load i32, i32* %x
    ret i32 %_173
}

define i32 @A.bar(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a

    %_174 = load i32, i32* %a
    call void @print_int(i32 %_174)
    %_175 = getelementptr i8, i8* %this, i32 9
    %_176 = bitcast i8* %_175 to i32*
    %_177 = load i32, i32* %_176
    call void @print_int(i32 %_177)
    %_178 = getelementptr i8, i8* %this, i32 13
    %_179 = bitcast i8* %_178 to i32**
    %_180 = add i32 5, 1
    %_181 = call i8* @calloc(i32 4, i32 %_180)
    %_182 = bitcast i8* %_181 to i32*
    store i32 5, i32* %_182
    store i32* %_182, i32** %_179
    %_183 = getelementptr i8, i8* %this, i32 13
    %_184 = bitcast i8* %_183 to i32**
    %_185 = load i32*, i32** %_184
    %_186 = icmp slt i32 2, 0
    br i1 %_186, label %Label69, label %Label67

Label67:
    %_187 = getelementptr i32, i32* %_185, i32 0
    %_188 = load i32, i32* %_187
    %_189 = icmp slt i32 2, %_188
    br i1 %_189, label %Label68, label %Label69

Label68:
    %_190 = add i32 2, 1
    %_191 = getelementptr i32, i32* %_185, i32 %_190
    store i32 666, i32* %_191
    br label %Label70

Label69:
    call void @throw_oob()
    br label %Label70

Label70:
    %_193 = getelementptr i8, i8* %this, i32 13
    %_194 = bitcast i8* %_193 to i32**
    %_195 = load i32*, i32** %_194
    %_196 = icmp slt i32 2, 0
    br i1 %_196, label %Label73, label %Label71

Label71:
    %_197 = getelementptr i32, i32* %_195, i32 0
    %_198 = load i32, i32* %_197
    %_199 = icmp slt i32 2, %_198
    br i1 %_199, label %Label72, label %Label73

Label72:
    %_200 = add i32 2, 1
    %_201 = getelementptr i32, i32* %_195, i32 %_200
    %_202 = load i32, i32* %_201
    br label %Label74

Label73:
    call void @throw_oob()
    br label %Label74

Label74:
    call void @print_int(i32 %_202)
    %_203 = getelementptr i8, i8* %this, i32 13
    %_204 = bitcast i8* %_203 to i32**
    %_205 = load i32*, i32** %_204
    %_206 = getelementptr i8, i8* %this, i32 21
    %_207 = bitcast i8* %_206 to i8**
    %_208 = load i8*, i8** %_207
    %_209 = bitcast i8* %_208 to i8***
    %_210 = load i8**, i8*** %_209
    %_211 = getelementptr i8*, i8** %_210, i32 3
    %_212 = load i8*, i8** %_211
    %_213 = bitcast i8* %_212 to i32 (i8*)*
    %_214 = call i32 %_213(i8* %_208)
    %_215 = icmp slt i32 0, 0
    br i1 %_215, label %Label77, label %Label75

Label75:
    %_216 = getelementptr i32, i32* %_205, i32 0
    %_217 = load i32, i32* %_216
    %_218 = icmp slt i32 0, %_217
    br i1 %_218, label %Label76, label %Label77

Label76:
    %_219 = add i32 0, 1
    %_220 = getelementptr i32, i32* %_205, i32 %_219
    store i32 %_214, i32* %_220
    br label %Label78

Label77:
    call void @throw_oob()
    br label %Label78

Label78:
    %_222 = getelementptr i8, i8* %this, i32 13
    %_223 = bitcast i8* %_222 to i32**
    %_224 = load i32*, i32** %_223
    %_225 = icmp slt i32 0, 0
    br i1 %_225, label %Label81, label %Label79

Label79:
    %_226 = getelementptr i32, i32* %_224, i32 0
    %_227 = load i32, i32* %_226
    %_228 = icmp slt i32 0, %_227
    br i1 %_228, label %Label80, label %Label81

Label80:
    %_229 = add i32 0, 1
    %_230 = getelementptr i32, i32* %_224, i32 %_229
    %_231 = load i32, i32* %_230
    br label %Label82

Label81:
    call void @throw_oob()
    br label %Label82

Label82:
    call void @print_int(i32 %_231)
    ret i32 0
}

define i32 @B.bar(i8* %this, i32 %.aa) {
    %aa = alloca i32
    store i32 %.aa, i32* %aa

    %x = alloca i32

    %_232 = load i32, i32* %aa
    store i32 %_232, i32* %x

    %_233 = load i32, i32* %x
    ret i32 %_233
}

define i32 @B.foo(i8* %this, i1 %.a, i32 %.aa) {
    %a = alloca i1
    store i1 %.a, i1* %a

    %aa = alloca i32
    store i32 %.aa, i32* %aa

    %x = alloca i32

    %_234 = getelementptr i8, i8* %this, i32 9
    %_235 = bitcast i8* %_234 to i32*
    store i32 666, i32* %_235
    %_236 = getelementptr i8, i8* %this, i32 21
    %_237 = bitcast i8* %_236 to i8**
    %_238 = call i8* @calloc(i32 1, i32 29)
    %_239 = bitcast i8* %_238 to i8***
    %_240 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    store i8** %_240, i8*** %_239
    store i8* %_238, i8** %_237
    %_241 = getelementptr i8, i8* %this, i32 8
    %_242 = bitcast i8* %_241 to i1*
    %_243 = load i1, i1* %_242
    br i1 %_243, label %Label83, label %Label84
Label83:
    call void @print_int(i32 1)
    br label %Label85
Label84:
    %_244 = getelementptr i8, i8* %this, i32 13
    %_245 = bitcast i8* %_244 to i32**
    %_246 = add i32 10, 1
    %_247 = call i8* @calloc(i32 4, i32 %_246)
    %_248 = bitcast i8* %_247 to i32*
    store i32 10, i32* %_248
    store i32* %_248, i32** %_245
    %_249 = getelementptr i8, i8* %this, i32 13
    %_250 = bitcast i8* %_249 to i32**
    %_251 = load i32*, i32** %_250
    %_252 = getelementptr i32, i32* %_251, i32 0
    %_253 = load i32, i32* %_252
    call void @print_int(i32 %_253)
    br label %Label85
Label85:

    %_254 = load i32, i32* %aa
    call void @print_int(i32 %_254)
    %_255 = load i1, i1* %a
    br i1 %_255, label %Label86, label %Label87
Label86:
    %_257 = load i32, i32* %aa
    %_256 = mul i32 2, %_257
    store i32 %_256, i32* %x

    br label %Label88
Label87:
    %_259 = load i32, i32* %aa
    %_258 = add i32 %_259, 7
    store i32 %_258, i32* %x

    br label %Label88
Label88:

    %_260 = load i32, i32* %x
    ret i32 %_260
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
