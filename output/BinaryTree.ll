@.BinaryTree_vtable = global [0 x i8*] []
@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*)]

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
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8***
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
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

define i32 @BT.Start(i8* %this) {
    %root = alloca i8*

    %ntb = alloca i1

    %nti = alloca i32

    %_9 = call i8* @calloc(i32 1, i32 38)
    %_10 = bitcast i8* %_9 to i8***
    %_11 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
    store i8** %_11, i8*** %_10
    store i8* %_9, i8** %root

    %_12 = load i8*, i8** %root
    %_13 = bitcast i8* %_12 to i8***
    %_14 = load i8**, i8*** %_13
    %_15 = getelementptr i8*, i8** %_14, i32 0
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i1 (i8*, i32)*
    %_18 = call i1 %_17(i8* %_12, i32 16)
    store i1 %_18, i1* %ntb

    %_19 = load i8*, i8** %root
    %_20 = bitcast i8* %_19 to i8***
    %_21 = load i8**, i8*** %_20
    %_22 = getelementptr i8*, i8** %_21, i32 18
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i1 (i8*)*
    %_25 = call i1 %_24(i8* %_19)
    store i1 %_25, i1* %ntb

    call void @print_int(i32 100000000)
    %_26 = load i8*, i8** %root
    %_27 = bitcast i8* %_26 to i8***
    %_28 = load i8**, i8*** %_27
    %_29 = getelementptr i8*, i8** %_28, i32 12
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i1 (i8*, i32)*
    %_32 = call i1 %_31(i8* %_26, i32 8)
    store i1 %_32, i1* %ntb

    %_33 = load i8*, i8** %root
    %_34 = bitcast i8* %_33 to i8***
    %_35 = load i8**, i8*** %_34
    %_36 = getelementptr i8*, i8** %_35, i32 18
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i1 (i8*)*
    %_39 = call i1 %_38(i8* %_33)
    store i1 %_39, i1* %ntb

    %_40 = load i8*, i8** %root
    %_41 = bitcast i8* %_40 to i8***
    %_42 = load i8**, i8*** %_41
    %_43 = getelementptr i8*, i8** %_42, i32 12
    %_44 = load i8*, i8** %_43
    %_45 = bitcast i8* %_44 to i1 (i8*, i32)*
    %_46 = call i1 %_45(i8* %_40, i32 24)
    store i1 %_46, i1* %ntb

    %_47 = load i8*, i8** %root
    %_48 = bitcast i8* %_47 to i8***
    %_49 = load i8**, i8*** %_48
    %_50 = getelementptr i8*, i8** %_49, i32 12
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i1 (i8*, i32)*
    %_53 = call i1 %_52(i8* %_47, i32 4)
    store i1 %_53, i1* %ntb

    %_54 = load i8*, i8** %root
    %_55 = bitcast i8* %_54 to i8***
    %_56 = load i8**, i8*** %_55
    %_57 = getelementptr i8*, i8** %_56, i32 12
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i1 (i8*, i32)*
    %_60 = call i1 %_59(i8* %_54, i32 12)
    store i1 %_60, i1* %ntb

    %_61 = load i8*, i8** %root
    %_62 = bitcast i8* %_61 to i8***
    %_63 = load i8**, i8*** %_62
    %_64 = getelementptr i8*, i8** %_63, i32 12
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i1 (i8*, i32)*
    %_67 = call i1 %_66(i8* %_61, i32 20)
    store i1 %_67, i1* %ntb

    %_68 = load i8*, i8** %root
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = getelementptr i8*, i8** %_70, i32 12
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i1 (i8*, i32)*
    %_74 = call i1 %_73(i8* %_68, i32 28)
    store i1 %_74, i1* %ntb

    %_75 = load i8*, i8** %root
    %_76 = bitcast i8* %_75 to i8***
    %_77 = load i8**, i8*** %_76
    %_78 = getelementptr i8*, i8** %_77, i32 12
    %_79 = load i8*, i8** %_78
    %_80 = bitcast i8* %_79 to i1 (i8*, i32)*
    %_81 = call i1 %_80(i8* %_75, i32 14)
    store i1 %_81, i1* %ntb

    %_82 = load i8*, i8** %root
    %_83 = bitcast i8* %_82 to i8***
    %_84 = load i8**, i8*** %_83
    %_85 = getelementptr i8*, i8** %_84, i32 18
    %_86 = load i8*, i8** %_85
    %_87 = bitcast i8* %_86 to i1 (i8*)*
    %_88 = call i1 %_87(i8* %_82)
    store i1 %_88, i1* %ntb

    %_89 = load i8*, i8** %root
    %_90 = bitcast i8* %_89 to i8***
    %_91 = load i8**, i8*** %_90
    %_92 = getelementptr i8*, i8** %_91, i32 17
    %_93 = load i8*, i8** %_92
    %_94 = bitcast i8* %_93 to i32 (i8*, i32)*
    %_95 = call i32 %_94(i8* %_89, i32 24)
    call void @print_int(i32 %_95)
    %_96 = load i8*, i8** %root
    %_97 = bitcast i8* %_96 to i8***
    %_98 = load i8**, i8*** %_97
    %_99 = getelementptr i8*, i8** %_98, i32 17
    %_100 = load i8*, i8** %_99
    %_101 = bitcast i8* %_100 to i32 (i8*, i32)*
    %_102 = call i32 %_101(i8* %_96, i32 12)
    call void @print_int(i32 %_102)
    %_103 = load i8*, i8** %root
    %_104 = bitcast i8* %_103 to i8***
    %_105 = load i8**, i8*** %_104
    %_106 = getelementptr i8*, i8** %_105, i32 17
    %_107 = load i8*, i8** %_106
    %_108 = bitcast i8* %_107 to i32 (i8*, i32)*
    %_109 = call i32 %_108(i8* %_103, i32 16)
    call void @print_int(i32 %_109)
    %_110 = load i8*, i8** %root
    %_111 = bitcast i8* %_110 to i8***
    %_112 = load i8**, i8*** %_111
    %_113 = getelementptr i8*, i8** %_112, i32 17
    %_114 = load i8*, i8** %_113
    %_115 = bitcast i8* %_114 to i32 (i8*, i32)*
    %_116 = call i32 %_115(i8* %_110, i32 50)
    call void @print_int(i32 %_116)
    %_117 = load i8*, i8** %root
    %_118 = bitcast i8* %_117 to i8***
    %_119 = load i8**, i8*** %_118
    %_120 = getelementptr i8*, i8** %_119, i32 17
    %_121 = load i8*, i8** %_120
    %_122 = bitcast i8* %_121 to i32 (i8*, i32)*
    %_123 = call i32 %_122(i8* %_117, i32 12)
    call void @print_int(i32 %_123)
    %_124 = load i8*, i8** %root
    %_125 = bitcast i8* %_124 to i8***
    %_126 = load i8**, i8*** %_125
    %_127 = getelementptr i8*, i8** %_126, i32 13
    %_128 = load i8*, i8** %_127
    %_129 = bitcast i8* %_128 to i1 (i8*, i32)*
    %_130 = call i1 %_129(i8* %_124, i32 12)
    store i1 %_130, i1* %ntb

    %_131 = load i8*, i8** %root
    %_132 = bitcast i8* %_131 to i8***
    %_133 = load i8**, i8*** %_132
    %_134 = getelementptr i8*, i8** %_133, i32 18
    %_135 = load i8*, i8** %_134
    %_136 = bitcast i8* %_135 to i1 (i8*)*
    %_137 = call i1 %_136(i8* %_131)
    store i1 %_137, i1* %ntb

    %_138 = load i8*, i8** %root
    %_139 = bitcast i8* %_138 to i8***
    %_140 = load i8**, i8*** %_139
    %_141 = getelementptr i8*, i8** %_140, i32 17
    %_142 = load i8*, i8** %_141
    %_143 = bitcast i8* %_142 to i32 (i8*, i32)*
    %_144 = call i32 %_143(i8* %_138, i32 12)
    call void @print_int(i32 %_144)
    ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %_145 = getelementptr i8, i8* %this, i32 24
    %_146 = bitcast i8* %_145 to i32*
    %_147 = load i32, i32* %v_key
    store i32 %_147, i32* %_146
    %_148 = getelementptr i8, i8* %this, i32 28
    %_149 = bitcast i8* %_148 to i1*
    store i1 0, i1* %_149
    %_150 = getelementptr i8, i8* %this, i32 29
    %_151 = bitcast i8* %_150 to i1*
    store i1 0, i1* %_151
    ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
    %rn = alloca i8*
    store i8* %.rn, i8** %rn

    %_152 = getelementptr i8, i8* %this, i32 16
    %_153 = bitcast i8* %_152 to i8**
    %_154 = load i8*, i8** %rn
    store i8* %_154, i8** %_153
    ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
    %ln = alloca i8*
    store i8* %.ln, i8** %ln

    %_155 = getelementptr i8, i8* %this, i32 8
    %_156 = bitcast i8* %_155 to i8**
    %_157 = load i8*, i8** %ln
    store i8* %_157, i8** %_156
    ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
    %_158 = getelementptr i8, i8* %this, i32 16
    %_159 = bitcast i8* %_158 to i8**
    %_160 = load i8*, i8** %_159
    ret i8* %_160
}

define i8* @Tree.GetLeft(i8* %this) {
    %_161 = getelementptr i8, i8* %this, i32 8
    %_162 = bitcast i8* %_161 to i8**
    %_163 = load i8*, i8** %_162
    ret i8* %_163
}

define i32 @Tree.GetKey(i8* %this) {
    %_164 = getelementptr i8, i8* %this, i32 24
    %_165 = bitcast i8* %_164 to i32*
    %_166 = load i32, i32* %_165
    ret i32 %_166
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %_167 = getelementptr i8, i8* %this, i32 24
    %_168 = bitcast i8* %_167 to i32*
    %_169 = load i32, i32* %v_key
    store i32 %_169, i32* %_168
    ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
    %_170 = getelementptr i8, i8* %this, i32 29
    %_171 = bitcast i8* %_170 to i1*
    %_172 = load i1, i1* %_171
    ret i1 %_172
}

define i1 @Tree.GetHas_Left(i8* %this) {
    %_173 = getelementptr i8, i8* %this, i32 28
    %_174 = bitcast i8* %_173 to i1*
    %_175 = load i1, i1* %_174
    ret i1 %_175
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val

    %_176 = getelementptr i8, i8* %this, i32 28
    %_177 = bitcast i8* %_176 to i1*
    %_178 = load i1, i1* %val
    store i1 %_178, i1* %_177
    ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val

    %_179 = getelementptr i8, i8* %this, i32 29
    %_180 = bitcast i8* %_179 to i1*
    %_181 = load i1, i1* %val
    store i1 %_181, i1* %_180
    ret i1 1
}

define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1

    %num2 = alloca i32
    store i32 %.num2, i32* %num2

    %ntb = alloca i1

    %nti = alloca i32

    store i1 0, i1* %ntb

    %_183 = load i32, i32* %num2
    %_182 = add i32 %_183, 1
    store i32 %_182, i32* %nti

    %_185 = load i32, i32* %num1
    %_186 = load i32, i32* %num2
    %_184 = icmp slt i32 %_185, %_186
    br i1 %_184, label %Label0, label %Label1
Label0:
    store i1 0, i1* %ntb

    br label %Label2
Label1:
    %_189 = load i32, i32* %num1
    %_190 = load i32, i32* %nti
    %_188 = icmp slt i32 %_189, %_190
    %_187 = add i1 %_188, 1
    br i1 %_187, label %Label3, label %Label4
Label3:
    store i1 0, i1* %ntb

    br label %Label5
Label4:
    store i1 1, i1* %ntb

    br label %Label5
Label5:

    br label %Label2
Label2:

    %_191 = load i1, i1* %ntb
    ret i1 %_191
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %new_node = alloca i8*

    %ntb = alloca i1

    %cont = alloca i1

    %key_aux = alloca i32

    %current_node = alloca i8*

    %_192 = call i8* @calloc(i32 1, i32 38)
    %_193 = bitcast i8* %_192 to i8***
    %_194 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
    store i8** %_194, i8*** %_193
    store i8* %_192, i8** %new_node

    %_195 = load i8*, i8** %new_node
    %_196 = bitcast i8* %_195 to i8***
    %_197 = load i8**, i8*** %_196
    %_198 = getelementptr i8*, i8** %_197, i32 0
    %_199 = load i8*, i8** %_198
    %_200 = bitcast i8* %_199 to i1 (i8*, i32)*
    %_201 = load i32, i32* %v_key
    %_202 = call i1 %_200(i8* %_195, i32 %_201)
    store i1 %_202, i1* %ntb

    store i8* %this, i8** %current_node

    store i1 1, i1* %cont

    br label %Label6
Label6:
    %_203 = load i1, i1* %cont
    br i1 %_203, label %Label7, label %Label8
Label7:
    %_204 = load i8*, i8** %current_node
    %_205 = bitcast i8* %_204 to i8***
    %_206 = load i8**, i8*** %_205
    %_207 = getelementptr i8*, i8** %_206, i32 5
    %_208 = load i8*, i8** %_207
    %_209 = bitcast i8* %_208 to i32 (i8*)*
    %_210 = call i32 %_209(i8* %_204)
    store i32 %_210, i32* %key_aux

    %_212 = load i32, i32* %v_key
    %_213 = load i32, i32* %key_aux
    %_211 = icmp slt i32 %_212, %_213
    br i1 %_211, label %Label9, label %Label10
Label9:
    %_214 = load i8*, i8** %current_node
    %_215 = bitcast i8* %_214 to i8***
    %_216 = load i8**, i8*** %_215
    %_217 = getelementptr i8*, i8** %_216, i32 8
    %_218 = load i8*, i8** %_217
    %_219 = bitcast i8* %_218 to i1 (i8*)*
    %_220 = call i1 %_219(i8* %_214)
    br i1 %_220, label %Label12, label %Label13
Label12:
    %_221 = load i8*, i8** %current_node
    %_222 = bitcast i8* %_221 to i8***
    %_223 = load i8**, i8*** %_222
    %_224 = getelementptr i8*, i8** %_223, i32 4
    %_225 = load i8*, i8** %_224
    %_226 = bitcast i8* %_225 to i8* (i8*)*
    %_227 = call i8* %_226(i8* %_221)
    store i8* %_227, i8** %current_node

    br label %Label14
Label13:
    store i1 0, i1* %cont

    %_228 = load i8*, i8** %current_node
    %_229 = bitcast i8* %_228 to i8***
    %_230 = load i8**, i8*** %_229
    %_231 = getelementptr i8*, i8** %_230, i32 9
    %_232 = load i8*, i8** %_231
    %_233 = bitcast i8* %_232 to i1 (i8*, i1)*
    %_234 = call i1 %_233(i8* %_228, i1 1)
    store i1 %_234, i1* %ntb

    %_235 = load i8*, i8** %current_node
    %_236 = bitcast i8* %_235 to i8***
    %_237 = load i8**, i8*** %_236
    %_238 = getelementptr i8*, i8** %_237, i32 2
    %_239 = load i8*, i8** %_238
    %_240 = bitcast i8* %_239 to i1 (i8*, i8*)*
    %_241 = load i8*, i8** %new_node
    %_242 = call i1 %_240(i8* %_235, i8* %_241)
    store i1 %_242, i1* %ntb

    br label %Label14
Label14:

    br label %Label11
Label10:
    %_243 = load i8*, i8** %current_node
    %_244 = bitcast i8* %_243 to i8***
    %_245 = load i8**, i8*** %_244
    %_246 = getelementptr i8*, i8** %_245, i32 7
    %_247 = load i8*, i8** %_246
    %_248 = bitcast i8* %_247 to i1 (i8*)*
    %_249 = call i1 %_248(i8* %_243)
    br i1 %_249, label %Label15, label %Label16
Label15:
    %_250 = load i8*, i8** %current_node
    %_251 = bitcast i8* %_250 to i8***
    %_252 = load i8**, i8*** %_251
    %_253 = getelementptr i8*, i8** %_252, i32 3
    %_254 = load i8*, i8** %_253
    %_255 = bitcast i8* %_254 to i8* (i8*)*
    %_256 = call i8* %_255(i8* %_250)
    store i8* %_256, i8** %current_node

    br label %Label17
Label16:
    store i1 0, i1* %cont

    %_257 = load i8*, i8** %current_node
    %_258 = bitcast i8* %_257 to i8***
    %_259 = load i8**, i8*** %_258
    %_260 = getelementptr i8*, i8** %_259, i32 10
    %_261 = load i8*, i8** %_260
    %_262 = bitcast i8* %_261 to i1 (i8*, i1)*
    %_263 = call i1 %_262(i8* %_257, i1 1)
    store i1 %_263, i1* %ntb

    %_264 = load i8*, i8** %current_node
    %_265 = bitcast i8* %_264 to i8***
    %_266 = load i8**, i8*** %_265
    %_267 = getelementptr i8*, i8** %_266, i32 1
    %_268 = load i8*, i8** %_267
    %_269 = bitcast i8* %_268 to i1 (i8*, i8*)*
    %_270 = load i8*, i8** %new_node
    %_271 = call i1 %_269(i8* %_264, i8* %_270)
    store i1 %_271, i1* %ntb

    br label %Label17
Label17:

    br label %Label11
Label11:

    br label %Label6
Label8:

    ret i1 1
}

define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %current_node = alloca i8*

    %parent_node = alloca i8*

    %cont = alloca i1

    %found = alloca i1

    %is_root = alloca i1

    %key_aux = alloca i32

    %ntb = alloca i1

    store i8* %this, i8** %current_node

    store i8* %this, i8** %parent_node

    store i1 1, i1* %cont

    store i1 0, i1* %found

    store i1 1, i1* %is_root

    br label %Label18
Label18:
    %_272 = load i1, i1* %cont
    br i1 %_272, label %Label19, label %Label20
Label19:
    %_273 = load i8*, i8** %current_node
    %_274 = bitcast i8* %_273 to i8***
    %_275 = load i8**, i8*** %_274
    %_276 = getelementptr i8*, i8** %_275, i32 5
    %_277 = load i8*, i8** %_276
    %_278 = bitcast i8* %_277 to i32 (i8*)*
    %_279 = call i32 %_278(i8* %_273)
    store i32 %_279, i32* %key_aux

    %_281 = load i32, i32* %v_key
    %_282 = load i32, i32* %key_aux
    %_280 = icmp slt i32 %_281, %_282
    br i1 %_280, label %Label21, label %Label22
Label21:
    %_283 = load i8*, i8** %current_node
    %_284 = bitcast i8* %_283 to i8***
    %_285 = load i8**, i8*** %_284
    %_286 = getelementptr i8*, i8** %_285, i32 8
    %_287 = load i8*, i8** %_286
    %_288 = bitcast i8* %_287 to i1 (i8*)*
    %_289 = call i1 %_288(i8* %_283)
    br i1 %_289, label %Label24, label %Label25
Label24:
    %_290 = load i8*, i8** %current_node
    store i8* %_290, i8** %parent_node

    %_291 = load i8*, i8** %current_node
    %_292 = bitcast i8* %_291 to i8***
    %_293 = load i8**, i8*** %_292
    %_294 = getelementptr i8*, i8** %_293, i32 4
    %_295 = load i8*, i8** %_294
    %_296 = bitcast i8* %_295 to i8* (i8*)*
    %_297 = call i8* %_296(i8* %_291)
    store i8* %_297, i8** %current_node

    br label %Label26
Label25:
    store i1 0, i1* %cont

    br label %Label26
Label26:

    br label %Label23
Label22:
    %_299 = load i32, i32* %key_aux
    %_300 = load i32, i32* %v_key
    %_298 = icmp slt i32 %_299, %_300
    br i1 %_298, label %Label27, label %Label28
Label27:
    %_301 = load i8*, i8** %current_node
    %_302 = bitcast i8* %_301 to i8***
    %_303 = load i8**, i8*** %_302
    %_304 = getelementptr i8*, i8** %_303, i32 7
    %_305 = load i8*, i8** %_304
    %_306 = bitcast i8* %_305 to i1 (i8*)*
    %_307 = call i1 %_306(i8* %_301)
    br i1 %_307, label %Label30, label %Label31
Label30:
    %_308 = load i8*, i8** %current_node
    store i8* %_308, i8** %parent_node

    %_309 = load i8*, i8** %current_node
    %_310 = bitcast i8* %_309 to i8***
    %_311 = load i8**, i8*** %_310
    %_312 = getelementptr i8*, i8** %_311, i32 3
    %_313 = load i8*, i8** %_312
    %_314 = bitcast i8* %_313 to i8* (i8*)*
    %_315 = call i8* %_314(i8* %_309)
    store i8* %_315, i8** %current_node

    br label %Label32
Label31:
    store i1 0, i1* %cont

    br label %Label32
Label32:

    br label %Label29
Label28:
    %_316 = load i1, i1* %is_root
    br i1 %_316, label %Label33, label %Label34
Label33:
    %_317 = alloca i1
    %_319 = load i8*, i8** %current_node
    %_320 = bitcast i8* %_319 to i8***
    %_321 = load i8**, i8*** %_320
    %_322 = getelementptr i8*, i8** %_321, i32 7
    %_323 = load i8*, i8** %_322
    %_324 = bitcast i8* %_323 to i1 (i8*)*
    %_325 = call i1 %_324(i8* %_319)
    %_318 = add i1 %_325, 1
    br i1 %_318, label %Label40, label %Label41
Label40:
    %_327 = load i8*, i8** %current_node
    %_328 = bitcast i8* %_327 to i8***
    %_329 = load i8**, i8*** %_328
    %_330 = getelementptr i8*, i8** %_329, i32 8
    %_331 = load i8*, i8** %_330
    %_332 = bitcast i8* %_331 to i1 (i8*)*
    %_333 = call i1 %_332(i8* %_327)
    %_326 = add i1 %_333, 1
    br i1 %_326, label %Label39, label %Label41
Label39:
    store i1 1 , i1* %_317
    br label %Label42
Label41:
    store i1 0 , i1* %_317
    br label %Label42
Label42:
    %_334 = load i1, i1* %_317
    br i1 %_334, label %Label36, label %Label37
Label36:
    store i1 1, i1* %ntb

    br label %Label38
Label37:
    %_335 = bitcast i8* %this to i8***
    %_336 = load i8**, i8*** %_335
    %_337 = getelementptr i8*, i8** %_336, i32 14
    %_338 = load i8*, i8** %_337
    %_339 = bitcast i8* %_338 to i1 (i8*, i8*, i8*)*
    %_340 = load i8*, i8** %parent_node
    %_341 = load i8*, i8** %current_node
    %_342 = call i1 %_339(i8* %this, i8* %_340, i8* %_341)
    store i1 %_342, i1* %ntb

    br label %Label38
Label38:

    br label %Label35
Label34:
    %_343 = bitcast i8* %this to i8***
    %_344 = load i8**, i8*** %_343
    %_345 = getelementptr i8*, i8** %_344, i32 14
    %_346 = load i8*, i8** %_345
    %_347 = bitcast i8* %_346 to i1 (i8*, i8*, i8*)*
    %_348 = load i8*, i8** %parent_node
    %_349 = load i8*, i8** %current_node
    %_350 = call i1 %_347(i8* %this, i8* %_348, i8* %_349)
    store i1 %_350, i1* %ntb

    br label %Label35
Label35:

    store i1 1, i1* %found

    store i1 0, i1* %cont

    br label %Label29
Label29:

    br label %Label23
Label23:

    store i1 0, i1* %is_root

    br label %Label18
Label20:

    %_351 = load i1, i1* %found
    ret i1 %_351
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node

    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node

    %ntb = alloca i1

    %auxkey1 = alloca i32

    %auxkey2 = alloca i32

    %_352 = load i8*, i8** %c_node
    %_353 = bitcast i8* %_352 to i8***
    %_354 = load i8**, i8*** %_353
    %_355 = getelementptr i8*, i8** %_354, i32 8
    %_356 = load i8*, i8** %_355
    %_357 = bitcast i8* %_356 to i1 (i8*)*
    %_358 = call i1 %_357(i8* %_352)
    br i1 %_358, label %Label43, label %Label44
Label43:
    %_359 = bitcast i8* %this to i8***
    %_360 = load i8**, i8*** %_359
    %_361 = getelementptr i8*, i8** %_360, i32 16
    %_362 = load i8*, i8** %_361
    %_363 = bitcast i8* %_362 to i1 (i8*, i8*, i8*)*
    %_364 = load i8*, i8** %p_node
    %_365 = load i8*, i8** %c_node
    %_366 = call i1 %_363(i8* %this, i8* %_364, i8* %_365)
    store i1 %_366, i1* %ntb

    br label %Label45
Label44:
    %_367 = load i8*, i8** %c_node
    %_368 = bitcast i8* %_367 to i8***
    %_369 = load i8**, i8*** %_368
    %_370 = getelementptr i8*, i8** %_369, i32 7
    %_371 = load i8*, i8** %_370
    %_372 = bitcast i8* %_371 to i1 (i8*)*
    %_373 = call i1 %_372(i8* %_367)
    br i1 %_373, label %Label46, label %Label47
Label46:
    %_374 = bitcast i8* %this to i8***
    %_375 = load i8**, i8*** %_374
    %_376 = getelementptr i8*, i8** %_375, i32 15
    %_377 = load i8*, i8** %_376
    %_378 = bitcast i8* %_377 to i1 (i8*, i8*, i8*)*
    %_379 = load i8*, i8** %p_node
    %_380 = load i8*, i8** %c_node
    %_381 = call i1 %_378(i8* %this, i8* %_379, i8* %_380)
    store i1 %_381, i1* %ntb

    br label %Label48
Label47:
    %_382 = load i8*, i8** %c_node
    %_383 = bitcast i8* %_382 to i8***
    %_384 = load i8**, i8*** %_383
    %_385 = getelementptr i8*, i8** %_384, i32 5
    %_386 = load i8*, i8** %_385
    %_387 = bitcast i8* %_386 to i32 (i8*)*
    %_388 = call i32 %_387(i8* %_382)
    store i32 %_388, i32* %auxkey1

    %_389 = load i8*, i8** %p_node
    %_390 = bitcast i8* %_389 to i8***
    %_391 = load i8**, i8*** %_390
    %_392 = getelementptr i8*, i8** %_391, i32 4
    %_393 = load i8*, i8** %_392
    %_394 = bitcast i8* %_393 to i8* (i8*)*
    %_395 = call i8* %_394(i8* %_389)
    %_396 = bitcast i8* %_395 to i8***
    %_397 = load i8**, i8*** %_396
    %_398 = getelementptr i8*, i8** %_397, i32 5
    %_399 = load i8*, i8** %_398
    %_400 = bitcast i8* %_399 to i32 (i8*)*
    %_401 = call i32 %_400(i8* %_395)
    store i32 %_401, i32* %auxkey2

    %_402 = bitcast i8* %this to i8***
    %_403 = load i8**, i8*** %_402
    %_404 = getelementptr i8*, i8** %_403, i32 11
    %_405 = load i8*, i8** %_404
    %_406 = bitcast i8* %_405 to i1 (i8*, i32, i32)*
    %_407 = load i32, i32* %auxkey1
    %_408 = load i32, i32* %auxkey2
    %_409 = call i1 %_406(i8* %this, i32 %_407, i32 %_408)
    br i1 %_409, label %Label49, label %Label50
Label49:
    %_410 = load i8*, i8** %p_node
    %_411 = bitcast i8* %_410 to i8***
    %_412 = load i8**, i8*** %_411
    %_413 = getelementptr i8*, i8** %_412, i32 2
    %_414 = load i8*, i8** %_413
    %_415 = bitcast i8* %_414 to i1 (i8*, i8*)*
    %_416 = getelementptr i8, i8* %this, i32 30
    %_417 = bitcast i8* %_416 to i8**
    %_418 = load i8*, i8** %_417
    %_419 = call i1 %_415(i8* %_410, i8* %_418)
    store i1 %_419, i1* %ntb

    %_420 = load i8*, i8** %p_node
    %_421 = bitcast i8* %_420 to i8***
    %_422 = load i8**, i8*** %_421
    %_423 = getelementptr i8*, i8** %_422, i32 9
    %_424 = load i8*, i8** %_423
    %_425 = bitcast i8* %_424 to i1 (i8*, i1)*
    %_426 = call i1 %_425(i8* %_420, i1 0)
    store i1 %_426, i1* %ntb

    br label %Label51
Label50:
    %_427 = load i8*, i8** %p_node
    %_428 = bitcast i8* %_427 to i8***
    %_429 = load i8**, i8*** %_428
    %_430 = getelementptr i8*, i8** %_429, i32 1
    %_431 = load i8*, i8** %_430
    %_432 = bitcast i8* %_431 to i1 (i8*, i8*)*
    %_433 = getelementptr i8, i8* %this, i32 30
    %_434 = bitcast i8* %_433 to i8**
    %_435 = load i8*, i8** %_434
    %_436 = call i1 %_432(i8* %_427, i8* %_435)
    store i1 %_436, i1* %ntb

    %_437 = load i8*, i8** %p_node
    %_438 = bitcast i8* %_437 to i8***
    %_439 = load i8**, i8*** %_438
    %_440 = getelementptr i8*, i8** %_439, i32 10
    %_441 = load i8*, i8** %_440
    %_442 = bitcast i8* %_441 to i1 (i8*, i1)*
    %_443 = call i1 %_442(i8* %_437, i1 0)
    store i1 %_443, i1* %ntb

    br label %Label51
Label51:

    br label %Label48
Label48:

    br label %Label45
Label45:

    ret i1 1
}

define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node

    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node

    %ntb = alloca i1

    br label %Label52
Label52:
    %_444 = load i8*, i8** %c_node
    %_445 = bitcast i8* %_444 to i8***
    %_446 = load i8**, i8*** %_445
    %_447 = getelementptr i8*, i8** %_446, i32 7
    %_448 = load i8*, i8** %_447
    %_449 = bitcast i8* %_448 to i1 (i8*)*
    %_450 = call i1 %_449(i8* %_444)
    br i1 %_450, label %Label53, label %Label54
Label53:
    %_451 = load i8*, i8** %c_node
    %_452 = bitcast i8* %_451 to i8***
    %_453 = load i8**, i8*** %_452
    %_454 = getelementptr i8*, i8** %_453, i32 6
    %_455 = load i8*, i8** %_454
    %_456 = bitcast i8* %_455 to i1 (i8*, i32)*
    %_457 = load i8*, i8** %c_node
    %_458 = bitcast i8* %_457 to i8***
    %_459 = load i8**, i8*** %_458
    %_460 = getelementptr i8*, i8** %_459, i32 3
    %_461 = load i8*, i8** %_460
    %_462 = bitcast i8* %_461 to i8* (i8*)*
    %_463 = call i8* %_462(i8* %_457)
    %_464 = bitcast i8* %_463 to i8***
    %_465 = load i8**, i8*** %_464
    %_466 = getelementptr i8*, i8** %_465, i32 5
    %_467 = load i8*, i8** %_466
    %_468 = bitcast i8* %_467 to i32 (i8*)*
    %_469 = call i32 %_468(i8* %_463)
    %_470 = call i1 %_456(i8* %_451, i32 %_469)
    store i1 %_470, i1* %ntb

    %_471 = load i8*, i8** %c_node
    store i8* %_471, i8** %p_node

    %_472 = load i8*, i8** %c_node
    %_473 = bitcast i8* %_472 to i8***
    %_474 = load i8**, i8*** %_473
    %_475 = getelementptr i8*, i8** %_474, i32 3
    %_476 = load i8*, i8** %_475
    %_477 = bitcast i8* %_476 to i8* (i8*)*
    %_478 = call i8* %_477(i8* %_472)
    store i8* %_478, i8** %c_node

    br label %Label52
Label54:

    %_479 = load i8*, i8** %p_node
    %_480 = bitcast i8* %_479 to i8***
    %_481 = load i8**, i8*** %_480
    %_482 = getelementptr i8*, i8** %_481, i32 1
    %_483 = load i8*, i8** %_482
    %_484 = bitcast i8* %_483 to i1 (i8*, i8*)*
    %_485 = getelementptr i8, i8* %this, i32 30
    %_486 = bitcast i8* %_485 to i8**
    %_487 = load i8*, i8** %_486
    %_488 = call i1 %_484(i8* %_479, i8* %_487)
    store i1 %_488, i1* %ntb

    %_489 = load i8*, i8** %p_node
    %_490 = bitcast i8* %_489 to i8***
    %_491 = load i8**, i8*** %_490
    %_492 = getelementptr i8*, i8** %_491, i32 10
    %_493 = load i8*, i8** %_492
    %_494 = bitcast i8* %_493 to i1 (i8*, i1)*
    %_495 = call i1 %_494(i8* %_489, i1 0)
    store i1 %_495, i1* %ntb

    ret i1 1
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node

    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node

    %ntb = alloca i1

    br label %Label55
Label55:
    %_496 = load i8*, i8** %c_node
    %_497 = bitcast i8* %_496 to i8***
    %_498 = load i8**, i8*** %_497
    %_499 = getelementptr i8*, i8** %_498, i32 8
    %_500 = load i8*, i8** %_499
    %_501 = bitcast i8* %_500 to i1 (i8*)*
    %_502 = call i1 %_501(i8* %_496)
    br i1 %_502, label %Label56, label %Label57
Label56:
    %_503 = load i8*, i8** %c_node
    %_504 = bitcast i8* %_503 to i8***
    %_505 = load i8**, i8*** %_504
    %_506 = getelementptr i8*, i8** %_505, i32 6
    %_507 = load i8*, i8** %_506
    %_508 = bitcast i8* %_507 to i1 (i8*, i32)*
    %_509 = load i8*, i8** %c_node
    %_510 = bitcast i8* %_509 to i8***
    %_511 = load i8**, i8*** %_510
    %_512 = getelementptr i8*, i8** %_511, i32 4
    %_513 = load i8*, i8** %_512
    %_514 = bitcast i8* %_513 to i8* (i8*)*
    %_515 = call i8* %_514(i8* %_509)
    %_516 = bitcast i8* %_515 to i8***
    %_517 = load i8**, i8*** %_516
    %_518 = getelementptr i8*, i8** %_517, i32 5
    %_519 = load i8*, i8** %_518
    %_520 = bitcast i8* %_519 to i32 (i8*)*
    %_521 = call i32 %_520(i8* %_515)
    %_522 = call i1 %_508(i8* %_503, i32 %_521)
    store i1 %_522, i1* %ntb

    %_523 = load i8*, i8** %c_node
    store i8* %_523, i8** %p_node

    %_524 = load i8*, i8** %c_node
    %_525 = bitcast i8* %_524 to i8***
    %_526 = load i8**, i8*** %_525
    %_527 = getelementptr i8*, i8** %_526, i32 4
    %_528 = load i8*, i8** %_527
    %_529 = bitcast i8* %_528 to i8* (i8*)*
    %_530 = call i8* %_529(i8* %_524)
    store i8* %_530, i8** %c_node

    br label %Label55
Label57:

    %_531 = load i8*, i8** %p_node
    %_532 = bitcast i8* %_531 to i8***
    %_533 = load i8**, i8*** %_532
    %_534 = getelementptr i8*, i8** %_533, i32 2
    %_535 = load i8*, i8** %_534
    %_536 = bitcast i8* %_535 to i1 (i8*, i8*)*
    %_537 = getelementptr i8, i8* %this, i32 30
    %_538 = bitcast i8* %_537 to i8**
    %_539 = load i8*, i8** %_538
    %_540 = call i1 %_536(i8* %_531, i8* %_539)
    store i1 %_540, i1* %ntb

    %_541 = load i8*, i8** %p_node
    %_542 = bitcast i8* %_541 to i8***
    %_543 = load i8**, i8*** %_542
    %_544 = getelementptr i8*, i8** %_543, i32 9
    %_545 = load i8*, i8** %_544
    %_546 = bitcast i8* %_545 to i1 (i8*, i1)*
    %_547 = call i1 %_546(i8* %_541, i1 0)
    store i1 %_547, i1* %ntb

    ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %cont = alloca i1

    %ifound = alloca i32

    %current_node = alloca i8*

    %key_aux = alloca i32

    store i8* %this, i8** %current_node

    store i1 1, i1* %cont

    store i32 0, i32* %ifound

    br label %Label58
Label58:
    %_548 = load i1, i1* %cont
    br i1 %_548, label %Label59, label %Label60
Label59:
    %_549 = load i8*, i8** %current_node
    %_550 = bitcast i8* %_549 to i8***
    %_551 = load i8**, i8*** %_550
    %_552 = getelementptr i8*, i8** %_551, i32 5
    %_553 = load i8*, i8** %_552
    %_554 = bitcast i8* %_553 to i32 (i8*)*
    %_555 = call i32 %_554(i8* %_549)
    store i32 %_555, i32* %key_aux

    %_557 = load i32, i32* %v_key
    %_558 = load i32, i32* %key_aux
    %_556 = icmp slt i32 %_557, %_558
    br i1 %_556, label %Label61, label %Label62
Label61:
    %_559 = load i8*, i8** %current_node
    %_560 = bitcast i8* %_559 to i8***
    %_561 = load i8**, i8*** %_560
    %_562 = getelementptr i8*, i8** %_561, i32 8
    %_563 = load i8*, i8** %_562
    %_564 = bitcast i8* %_563 to i1 (i8*)*
    %_565 = call i1 %_564(i8* %_559)
    br i1 %_565, label %Label64, label %Label65
Label64:
    %_566 = load i8*, i8** %current_node
    %_567 = bitcast i8* %_566 to i8***
    %_568 = load i8**, i8*** %_567
    %_569 = getelementptr i8*, i8** %_568, i32 4
    %_570 = load i8*, i8** %_569
    %_571 = bitcast i8* %_570 to i8* (i8*)*
    %_572 = call i8* %_571(i8* %_566)
    store i8* %_572, i8** %current_node

    br label %Label66
Label65:
    store i1 0, i1* %cont

    br label %Label66
Label66:

    br label %Label63
Label62:
    %_574 = load i32, i32* %key_aux
    %_575 = load i32, i32* %v_key
    %_573 = icmp slt i32 %_574, %_575
    br i1 %_573, label %Label67, label %Label68
Label67:
    %_576 = load i8*, i8** %current_node
    %_577 = bitcast i8* %_576 to i8***
    %_578 = load i8**, i8*** %_577
    %_579 = getelementptr i8*, i8** %_578, i32 7
    %_580 = load i8*, i8** %_579
    %_581 = bitcast i8* %_580 to i1 (i8*)*
    %_582 = call i1 %_581(i8* %_576)
    br i1 %_582, label %Label70, label %Label71
Label70:
    %_583 = load i8*, i8** %current_node
    %_584 = bitcast i8* %_583 to i8***
    %_585 = load i8**, i8*** %_584
    %_586 = getelementptr i8*, i8** %_585, i32 3
    %_587 = load i8*, i8** %_586
    %_588 = bitcast i8* %_587 to i8* (i8*)*
    %_589 = call i8* %_588(i8* %_583)
    store i8* %_589, i8** %current_node

    br label %Label72
Label71:
    store i1 0, i1* %cont

    br label %Label72
Label72:

    br label %Label69
Label68:
    store i32 1, i32* %ifound

    store i1 0, i1* %cont

    br label %Label69
Label69:

    br label %Label63
Label63:

    br label %Label58
Label60:

    %_590 = load i32, i32* %ifound
    ret i32 %_590
}

define i1 @Tree.Print(i8* %this) {
    %current_node = alloca i8*

    %ntb = alloca i1

    store i8* %this, i8** %current_node

    %_591 = bitcast i8* %this to i8***
    %_592 = load i8**, i8*** %_591
    %_593 = getelementptr i8*, i8** %_592, i32 19
    %_594 = load i8*, i8** %_593
    %_595 = bitcast i8* %_594 to i1 (i8*, i8*)*
    %_596 = load i8*, i8** %current_node
    %_597 = call i1 %_595(i8* %this, i8* %_596)
    store i1 %_597, i1* %ntb

    ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
    %node = alloca i8*
    store i8* %.node, i8** %node

    %ntb = alloca i1

    %_598 = load i8*, i8** %node
    %_599 = bitcast i8* %_598 to i8***
    %_600 = load i8**, i8*** %_599
    %_601 = getelementptr i8*, i8** %_600, i32 8
    %_602 = load i8*, i8** %_601
    %_603 = bitcast i8* %_602 to i1 (i8*)*
    %_604 = call i1 %_603(i8* %_598)
    br i1 %_604, label %Label73, label %Label74
Label73:
    %_605 = bitcast i8* %this to i8***
    %_606 = load i8**, i8*** %_605
    %_607 = getelementptr i8*, i8** %_606, i32 19
    %_608 = load i8*, i8** %_607
    %_609 = bitcast i8* %_608 to i1 (i8*, i8*)*
    %_610 = load i8*, i8** %node
    %_611 = bitcast i8* %_610 to i8***
    %_612 = load i8**, i8*** %_611
    %_613 = getelementptr i8*, i8** %_612, i32 4
    %_614 = load i8*, i8** %_613
    %_615 = bitcast i8* %_614 to i8* (i8*)*
    %_616 = call i8* %_615(i8* %_610)
    %_617 = call i1 %_609(i8* %this, i8* %_616)
    store i1 %_617, i1* %ntb

    br label %Label75
Label74:
    store i1 1, i1* %ntb

    br label %Label75
Label75:

    %_618 = load i8*, i8** %node
    %_619 = bitcast i8* %_618 to i8***
    %_620 = load i8**, i8*** %_619
    %_621 = getelementptr i8*, i8** %_620, i32 5
    %_622 = load i8*, i8** %_621
    %_623 = bitcast i8* %_622 to i32 (i8*)*
    %_624 = call i32 %_623(i8* %_618)
    call void @print_int(i32 %_624)
    %_625 = load i8*, i8** %node
    %_626 = bitcast i8* %_625 to i8***
    %_627 = load i8**, i8*** %_626
    %_628 = getelementptr i8*, i8** %_627, i32 7
    %_629 = load i8*, i8** %_628
    %_630 = bitcast i8* %_629 to i1 (i8*)*
    %_631 = call i1 %_630(i8* %_625)
    br i1 %_631, label %Label76, label %Label77
Label76:
    %_632 = bitcast i8* %this to i8***
    %_633 = load i8**, i8*** %_632
    %_634 = getelementptr i8*, i8** %_633, i32 19
    %_635 = load i8*, i8** %_634
    %_636 = bitcast i8* %_635 to i1 (i8*, i8*)*
    %_637 = load i8*, i8** %node
    %_638 = bitcast i8* %_637 to i8***
    %_639 = load i8**, i8*** %_638
    %_640 = getelementptr i8*, i8** %_639, i32 3
    %_641 = load i8*, i8** %_640
    %_642 = bitcast i8* %_641 to i8* (i8*)*
    %_643 = call i8* %_642(i8* %_637)
    %_644 = call i1 %_636(i8* %this, i8* %_643)
    store i1 %_644, i1* %ntb

    br label %Label78
Label77:
    store i1 1, i1* %ntb

    br label %Label78
Label78:

    ret i1 1
}
