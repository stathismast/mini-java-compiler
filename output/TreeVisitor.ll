@.TreeVisitor_vtable = global [0 x i8*] []
@.TV_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @TV.Start to i8*)]
@.Visitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i8*)* @Visitor.visit to i8*)]
@.Tree_vtable = global [21 x i8*] [i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*), i8* bitcast (i32 (i8*, i8*)* @Tree.accept to i8*)]
@.MyVisitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i8*)* @MyVisitor.visit to i8*)]

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
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0
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

define i32 @TV.Start(i8* %this) {
    %root = alloca i8*

    %ntb = alloca i1

    %nti = alloca i32

    %v = alloca i8*

    %_9 = call i8* @calloc(i32 1, i32 38)
    %_10 = bitcast i8* %_9 to i8***
    %_11 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
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
    %_36 = getelementptr i8*, i8** %_35, i32 12
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i1 (i8*, i32)*
    %_39 = call i1 %_38(i8* %_33, i32 24)
    store i1 %_39, i1* %ntb

    %_40 = load i8*, i8** %root
    %_41 = bitcast i8* %_40 to i8***
    %_42 = load i8**, i8*** %_41
    %_43 = getelementptr i8*, i8** %_42, i32 12
    %_44 = load i8*, i8** %_43
    %_45 = bitcast i8* %_44 to i1 (i8*, i32)*
    %_46 = call i1 %_45(i8* %_40, i32 4)
    store i1 %_46, i1* %ntb

    %_47 = load i8*, i8** %root
    %_48 = bitcast i8* %_47 to i8***
    %_49 = load i8**, i8*** %_48
    %_50 = getelementptr i8*, i8** %_49, i32 12
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i1 (i8*, i32)*
    %_53 = call i1 %_52(i8* %_47, i32 12)
    store i1 %_53, i1* %ntb

    %_54 = load i8*, i8** %root
    %_55 = bitcast i8* %_54 to i8***
    %_56 = load i8**, i8*** %_55
    %_57 = getelementptr i8*, i8** %_56, i32 12
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i1 (i8*, i32)*
    %_60 = call i1 %_59(i8* %_54, i32 20)
    store i1 %_60, i1* %ntb

    %_61 = load i8*, i8** %root
    %_62 = bitcast i8* %_61 to i8***
    %_63 = load i8**, i8*** %_62
    %_64 = getelementptr i8*, i8** %_63, i32 12
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i1 (i8*, i32)*
    %_67 = call i1 %_66(i8* %_61, i32 28)
    store i1 %_67, i1* %ntb

    %_68 = load i8*, i8** %root
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = getelementptr i8*, i8** %_70, i32 12
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i1 (i8*, i32)*
    %_74 = call i1 %_73(i8* %_68, i32 14)
    store i1 %_74, i1* %ntb

    %_75 = load i8*, i8** %root
    %_76 = bitcast i8* %_75 to i8***
    %_77 = load i8**, i8*** %_76
    %_78 = getelementptr i8*, i8** %_77, i32 18
    %_79 = load i8*, i8** %_78
    %_80 = bitcast i8* %_79 to i1 (i8*)*
    %_81 = call i1 %_80(i8* %_75)
    store i1 %_81, i1* %ntb

    call void @print_int(i32 100000000)
    %_82 = call i8* @calloc(i32 1, i32 24)
    %_83 = bitcast i8* %_82 to i8***
    %_84 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0
    store i8** %_84, i8*** %_83
    store i8* %_82, i8** %v

    call void @print_int(i32 50000000)
    %_85 = load i8*, i8** %root
    %_86 = bitcast i8* %_85 to i8***
    %_87 = load i8**, i8*** %_86
    %_88 = getelementptr i8*, i8** %_87, i32 20
    %_89 = load i8*, i8** %_88
    %_90 = bitcast i8* %_89 to i32 (i8*, i8*)*
    %_91 = load i8*, i8** %v
    %_92 = call i32 %_90(i8* %_85, i8* %_91)
    store i32 %_92, i32* %nti

    call void @print_int(i32 100000000)
    %_93 = load i8*, i8** %root
    %_94 = bitcast i8* %_93 to i8***
    %_95 = load i8**, i8*** %_94
    %_96 = getelementptr i8*, i8** %_95, i32 17
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i32 (i8*, i32)*
    %_99 = call i32 %_98(i8* %_93, i32 24)
    call void @print_int(i32 %_99)
    %_100 = load i8*, i8** %root
    %_101 = bitcast i8* %_100 to i8***
    %_102 = load i8**, i8*** %_101
    %_103 = getelementptr i8*, i8** %_102, i32 17
    %_104 = load i8*, i8** %_103
    %_105 = bitcast i8* %_104 to i32 (i8*, i32)*
    %_106 = call i32 %_105(i8* %_100, i32 12)
    call void @print_int(i32 %_106)
    %_107 = load i8*, i8** %root
    %_108 = bitcast i8* %_107 to i8***
    %_109 = load i8**, i8*** %_108
    %_110 = getelementptr i8*, i8** %_109, i32 17
    %_111 = load i8*, i8** %_110
    %_112 = bitcast i8* %_111 to i32 (i8*, i32)*
    %_113 = call i32 %_112(i8* %_107, i32 16)
    call void @print_int(i32 %_113)
    %_114 = load i8*, i8** %root
    %_115 = bitcast i8* %_114 to i8***
    %_116 = load i8**, i8*** %_115
    %_117 = getelementptr i8*, i8** %_116, i32 17
    %_118 = load i8*, i8** %_117
    %_119 = bitcast i8* %_118 to i32 (i8*, i32)*
    %_120 = call i32 %_119(i8* %_114, i32 50)
    call void @print_int(i32 %_120)
    %_121 = load i8*, i8** %root
    %_122 = bitcast i8* %_121 to i8***
    %_123 = load i8**, i8*** %_122
    %_124 = getelementptr i8*, i8** %_123, i32 17
    %_125 = load i8*, i8** %_124
    %_126 = bitcast i8* %_125 to i32 (i8*, i32)*
    %_127 = call i32 %_126(i8* %_121, i32 12)
    call void @print_int(i32 %_127)
    %_128 = load i8*, i8** %root
    %_129 = bitcast i8* %_128 to i8***
    %_130 = load i8**, i8*** %_129
    %_131 = getelementptr i8*, i8** %_130, i32 13
    %_132 = load i8*, i8** %_131
    %_133 = bitcast i8* %_132 to i1 (i8*, i32)*
    %_134 = call i1 %_133(i8* %_128, i32 12)
    store i1 %_134, i1* %ntb

    %_135 = load i8*, i8** %root
    %_136 = bitcast i8* %_135 to i8***
    %_137 = load i8**, i8*** %_136
    %_138 = getelementptr i8*, i8** %_137, i32 18
    %_139 = load i8*, i8** %_138
    %_140 = bitcast i8* %_139 to i1 (i8*)*
    %_141 = call i1 %_140(i8* %_135)
    store i1 %_141, i1* %ntb

    %_142 = load i8*, i8** %root
    %_143 = bitcast i8* %_142 to i8***
    %_144 = load i8**, i8*** %_143
    %_145 = getelementptr i8*, i8** %_144, i32 17
    %_146 = load i8*, i8** %_145
    %_147 = bitcast i8* %_146 to i32 (i8*, i32)*
    %_148 = call i32 %_147(i8* %_142, i32 12)
    call void @print_int(i32 %_148)
    ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %_149 = getelementptr i8, i8* %this, i32 24
    %_150 = bitcast i8* %_149 to i32*
    %_151 = load i32, i32* %v_key
    store i32 %_151, i32* %_150
    %_152 = getelementptr i8, i8* %this, i32 28
    %_153 = bitcast i8* %_152 to i1*
    store i1 0, i1* %_153
    %_154 = getelementptr i8, i8* %this, i32 29
    %_155 = bitcast i8* %_154 to i1*
    store i1 0, i1* %_155
    ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
    %rn = alloca i8*
    store i8* %.rn, i8** %rn

    %_156 = getelementptr i8, i8* %this, i32 16
    %_157 = bitcast i8* %_156 to i8**
    %_158 = load i8*, i8** %rn
    store i8* %_158, i8** %_157
    ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
    %ln = alloca i8*
    store i8* %.ln, i8** %ln

    %_159 = getelementptr i8, i8* %this, i32 8
    %_160 = bitcast i8* %_159 to i8**
    %_161 = load i8*, i8** %ln
    store i8* %_161, i8** %_160
    ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
    %_162 = getelementptr i8, i8* %this, i32 16
    %_163 = bitcast i8* %_162 to i8**
    %_164 = load i8*, i8** %_163
    ret i8* %_164
}

define i8* @Tree.GetLeft(i8* %this) {
    %_165 = getelementptr i8, i8* %this, i32 8
    %_166 = bitcast i8* %_165 to i8**
    %_167 = load i8*, i8** %_166
    ret i8* %_167
}

define i32 @Tree.GetKey(i8* %this) {
    %_168 = getelementptr i8, i8* %this, i32 24
    %_169 = bitcast i8* %_168 to i32*
    %_170 = load i32, i32* %_169
    ret i32 %_170
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %_171 = getelementptr i8, i8* %this, i32 24
    %_172 = bitcast i8* %_171 to i32*
    %_173 = load i32, i32* %v_key
    store i32 %_173, i32* %_172
    ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
    %_174 = getelementptr i8, i8* %this, i32 29
    %_175 = bitcast i8* %_174 to i1*
    %_176 = load i1, i1* %_175
    ret i1 %_176
}

define i1 @Tree.GetHas_Left(i8* %this) {
    %_177 = getelementptr i8, i8* %this, i32 28
    %_178 = bitcast i8* %_177 to i1*
    %_179 = load i1, i1* %_178
    ret i1 %_179
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val

    %_180 = getelementptr i8, i8* %this, i32 28
    %_181 = bitcast i8* %_180 to i1*
    %_182 = load i1, i1* %val
    store i1 %_182, i1* %_181
    ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val

    %_183 = getelementptr i8, i8* %this, i32 29
    %_184 = bitcast i8* %_183 to i1*
    %_185 = load i1, i1* %val
    store i1 %_185, i1* %_184
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

    %_187 = load i32, i32* %num2
    %_186 = add i32 %_187, 1
    store i32 %_186, i32* %nti

    %_189 = load i32, i32* %num1
    %_190 = load i32, i32* %num2
    %_188 = icmp slt i32 %_189, %_190
    br i1 %_188, label %Label0, label %Label1
Label0:
    store i1 0, i1* %ntb

    br label %Label2
Label1:
    %_193 = load i32, i32* %num1
    %_194 = load i32, i32* %nti
    %_192 = icmp slt i32 %_193, %_194
    %_191 = add i1 %_192, 1
    br i1 %_191, label %Label3, label %Label4
Label3:
    store i1 0, i1* %ntb

    br label %Label5
Label4:
    store i1 1, i1* %ntb

    br label %Label5
Label5:

    br label %Label2
Label2:

    %_195 = load i1, i1* %ntb
    ret i1 %_195
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %new_node = alloca i8*

    %ntb = alloca i1

    %current_node = alloca i8*

    %cont = alloca i1

    %key_aux = alloca i32

    %_196 = call i8* @calloc(i32 1, i32 38)
    %_197 = bitcast i8* %_196 to i8***
    %_198 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
    store i8** %_198, i8*** %_197
    store i8* %_196, i8** %new_node

    %_199 = load i8*, i8** %new_node
    %_200 = bitcast i8* %_199 to i8***
    %_201 = load i8**, i8*** %_200
    %_202 = getelementptr i8*, i8** %_201, i32 0
    %_203 = load i8*, i8** %_202
    %_204 = bitcast i8* %_203 to i1 (i8*, i32)*
    %_205 = load i32, i32* %v_key
    %_206 = call i1 %_204(i8* %_199, i32 %_205)
    store i1 %_206, i1* %ntb

    store i8* %this, i8** %current_node

    store i1 1, i1* %cont

    br label %Label6
Label6:
    %_207 = load i1, i1* %cont
    br i1 %_207, label %Label7, label %Label8
Label7:
    %_208 = load i8*, i8** %current_node
    %_209 = bitcast i8* %_208 to i8***
    %_210 = load i8**, i8*** %_209
    %_211 = getelementptr i8*, i8** %_210, i32 5
    %_212 = load i8*, i8** %_211
    %_213 = bitcast i8* %_212 to i32 (i8*)*
    %_214 = call i32 %_213(i8* %_208)
    store i32 %_214, i32* %key_aux

    %_216 = load i32, i32* %v_key
    %_217 = load i32, i32* %key_aux
    %_215 = icmp slt i32 %_216, %_217
    br i1 %_215, label %Label9, label %Label10
Label9:
    %_218 = load i8*, i8** %current_node
    %_219 = bitcast i8* %_218 to i8***
    %_220 = load i8**, i8*** %_219
    %_221 = getelementptr i8*, i8** %_220, i32 8
    %_222 = load i8*, i8** %_221
    %_223 = bitcast i8* %_222 to i1 (i8*)*
    %_224 = call i1 %_223(i8* %_218)
    br i1 %_224, label %Label12, label %Label13
Label12:
    %_225 = load i8*, i8** %current_node
    %_226 = bitcast i8* %_225 to i8***
    %_227 = load i8**, i8*** %_226
    %_228 = getelementptr i8*, i8** %_227, i32 4
    %_229 = load i8*, i8** %_228
    %_230 = bitcast i8* %_229 to i8* (i8*)*
    %_231 = call i8* %_230(i8* %_225)
    store i8* %_231, i8** %current_node

    br label %Label14
Label13:
    store i1 0, i1* %cont

    %_232 = load i8*, i8** %current_node
    %_233 = bitcast i8* %_232 to i8***
    %_234 = load i8**, i8*** %_233
    %_235 = getelementptr i8*, i8** %_234, i32 9
    %_236 = load i8*, i8** %_235
    %_237 = bitcast i8* %_236 to i1 (i8*, i1)*
    %_238 = call i1 %_237(i8* %_232, i1 1)
    store i1 %_238, i1* %ntb

    %_239 = load i8*, i8** %current_node
    %_240 = bitcast i8* %_239 to i8***
    %_241 = load i8**, i8*** %_240
    %_242 = getelementptr i8*, i8** %_241, i32 2
    %_243 = load i8*, i8** %_242
    %_244 = bitcast i8* %_243 to i1 (i8*, i8*)*
    %_245 = load i8*, i8** %new_node
    %_246 = call i1 %_244(i8* %_239, i8* %_245)
    store i1 %_246, i1* %ntb

    br label %Label14
Label14:

    br label %Label11
Label10:
    %_247 = load i8*, i8** %current_node
    %_248 = bitcast i8* %_247 to i8***
    %_249 = load i8**, i8*** %_248
    %_250 = getelementptr i8*, i8** %_249, i32 7
    %_251 = load i8*, i8** %_250
    %_252 = bitcast i8* %_251 to i1 (i8*)*
    %_253 = call i1 %_252(i8* %_247)
    br i1 %_253, label %Label15, label %Label16
Label15:
    %_254 = load i8*, i8** %current_node
    %_255 = bitcast i8* %_254 to i8***
    %_256 = load i8**, i8*** %_255
    %_257 = getelementptr i8*, i8** %_256, i32 3
    %_258 = load i8*, i8** %_257
    %_259 = bitcast i8* %_258 to i8* (i8*)*
    %_260 = call i8* %_259(i8* %_254)
    store i8* %_260, i8** %current_node

    br label %Label17
Label16:
    store i1 0, i1* %cont

    %_261 = load i8*, i8** %current_node
    %_262 = bitcast i8* %_261 to i8***
    %_263 = load i8**, i8*** %_262
    %_264 = getelementptr i8*, i8** %_263, i32 10
    %_265 = load i8*, i8** %_264
    %_266 = bitcast i8* %_265 to i1 (i8*, i1)*
    %_267 = call i1 %_266(i8* %_261, i1 1)
    store i1 %_267, i1* %ntb

    %_268 = load i8*, i8** %current_node
    %_269 = bitcast i8* %_268 to i8***
    %_270 = load i8**, i8*** %_269
    %_271 = getelementptr i8*, i8** %_270, i32 1
    %_272 = load i8*, i8** %_271
    %_273 = bitcast i8* %_272 to i1 (i8*, i8*)*
    %_274 = load i8*, i8** %new_node
    %_275 = call i1 %_273(i8* %_268, i8* %_274)
    store i1 %_275, i1* %ntb

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

    %ntb = alloca i1

    %is_root = alloca i1

    %key_aux = alloca i32

    store i8* %this, i8** %current_node

    store i8* %this, i8** %parent_node

    store i1 1, i1* %cont

    store i1 0, i1* %found

    store i1 1, i1* %is_root

    br label %Label18
Label18:
    %_276 = load i1, i1* %cont
    br i1 %_276, label %Label19, label %Label20
Label19:
    %_277 = load i8*, i8** %current_node
    %_278 = bitcast i8* %_277 to i8***
    %_279 = load i8**, i8*** %_278
    %_280 = getelementptr i8*, i8** %_279, i32 5
    %_281 = load i8*, i8** %_280
    %_282 = bitcast i8* %_281 to i32 (i8*)*
    %_283 = call i32 %_282(i8* %_277)
    store i32 %_283, i32* %key_aux

    %_285 = load i32, i32* %v_key
    %_286 = load i32, i32* %key_aux
    %_284 = icmp slt i32 %_285, %_286
    br i1 %_284, label %Label21, label %Label22
Label21:
    %_287 = load i8*, i8** %current_node
    %_288 = bitcast i8* %_287 to i8***
    %_289 = load i8**, i8*** %_288
    %_290 = getelementptr i8*, i8** %_289, i32 8
    %_291 = load i8*, i8** %_290
    %_292 = bitcast i8* %_291 to i1 (i8*)*
    %_293 = call i1 %_292(i8* %_287)
    br i1 %_293, label %Label24, label %Label25
Label24:
    %_294 = load i8*, i8** %current_node
    store i8* %_294, i8** %parent_node

    %_295 = load i8*, i8** %current_node
    %_296 = bitcast i8* %_295 to i8***
    %_297 = load i8**, i8*** %_296
    %_298 = getelementptr i8*, i8** %_297, i32 4
    %_299 = load i8*, i8** %_298
    %_300 = bitcast i8* %_299 to i8* (i8*)*
    %_301 = call i8* %_300(i8* %_295)
    store i8* %_301, i8** %current_node

    br label %Label26
Label25:
    store i1 0, i1* %cont

    br label %Label26
Label26:

    br label %Label23
Label22:
    %_303 = load i32, i32* %key_aux
    %_304 = load i32, i32* %v_key
    %_302 = icmp slt i32 %_303, %_304
    br i1 %_302, label %Label27, label %Label28
Label27:
    %_305 = load i8*, i8** %current_node
    %_306 = bitcast i8* %_305 to i8***
    %_307 = load i8**, i8*** %_306
    %_308 = getelementptr i8*, i8** %_307, i32 7
    %_309 = load i8*, i8** %_308
    %_310 = bitcast i8* %_309 to i1 (i8*)*
    %_311 = call i1 %_310(i8* %_305)
    br i1 %_311, label %Label30, label %Label31
Label30:
    %_312 = load i8*, i8** %current_node
    store i8* %_312, i8** %parent_node

    %_313 = load i8*, i8** %current_node
    %_314 = bitcast i8* %_313 to i8***
    %_315 = load i8**, i8*** %_314
    %_316 = getelementptr i8*, i8** %_315, i32 3
    %_317 = load i8*, i8** %_316
    %_318 = bitcast i8* %_317 to i8* (i8*)*
    %_319 = call i8* %_318(i8* %_313)
    store i8* %_319, i8** %current_node

    br label %Label32
Label31:
    store i1 0, i1* %cont

    br label %Label32
Label32:

    br label %Label29
Label28:
    %_320 = load i1, i1* %is_root
    br i1 %_320, label %Label33, label %Label34
Label33:
    %_321 = alloca i1
    %_323 = load i8*, i8** %current_node
    %_324 = bitcast i8* %_323 to i8***
    %_325 = load i8**, i8*** %_324
    %_326 = getelementptr i8*, i8** %_325, i32 7
    %_327 = load i8*, i8** %_326
    %_328 = bitcast i8* %_327 to i1 (i8*)*
    %_329 = call i1 %_328(i8* %_323)
    %_322 = add i1 %_329, 1
    br i1 %_322, label %Label40, label %Label41
Label40:
    %_331 = load i8*, i8** %current_node
    %_332 = bitcast i8* %_331 to i8***
    %_333 = load i8**, i8*** %_332
    %_334 = getelementptr i8*, i8** %_333, i32 8
    %_335 = load i8*, i8** %_334
    %_336 = bitcast i8* %_335 to i1 (i8*)*
    %_337 = call i1 %_336(i8* %_331)
    %_330 = add i1 %_337, 1
    br i1 %_330, label %Label39, label %Label41
Label39:
    store i1 1 , i1* %_321
    br label %Label42
Label41:
    store i1 0 , i1* %_321
    br label %Label42
Label42:
    %_338 = load i1, i1* %_321
    br i1 %_338, label %Label36, label %Label37
Label36:
    store i1 1, i1* %ntb

    br label %Label38
Label37:
    %_339 = bitcast i8* %this to i8***
    %_340 = load i8**, i8*** %_339
    %_341 = getelementptr i8*, i8** %_340, i32 14
    %_342 = load i8*, i8** %_341
    %_343 = bitcast i8* %_342 to i1 (i8*, i8*, i8*)*
    %_344 = load i8*, i8** %parent_node
    %_345 = load i8*, i8** %current_node
    %_346 = call i1 %_343(i8* %this, i8* %_344, i8* %_345)
    store i1 %_346, i1* %ntb

    br label %Label38
Label38:

    br label %Label35
Label34:
    %_347 = bitcast i8* %this to i8***
    %_348 = load i8**, i8*** %_347
    %_349 = getelementptr i8*, i8** %_348, i32 14
    %_350 = load i8*, i8** %_349
    %_351 = bitcast i8* %_350 to i1 (i8*, i8*, i8*)*
    %_352 = load i8*, i8** %parent_node
    %_353 = load i8*, i8** %current_node
    %_354 = call i1 %_351(i8* %this, i8* %_352, i8* %_353)
    store i1 %_354, i1* %ntb

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

    %_355 = load i1, i1* %found
    ret i1 %_355
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node

    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node

    %ntb = alloca i1

    %auxkey1 = alloca i32

    %auxkey2 = alloca i32

    %_356 = load i8*, i8** %c_node
    %_357 = bitcast i8* %_356 to i8***
    %_358 = load i8**, i8*** %_357
    %_359 = getelementptr i8*, i8** %_358, i32 8
    %_360 = load i8*, i8** %_359
    %_361 = bitcast i8* %_360 to i1 (i8*)*
    %_362 = call i1 %_361(i8* %_356)
    br i1 %_362, label %Label43, label %Label44
Label43:
    %_363 = bitcast i8* %this to i8***
    %_364 = load i8**, i8*** %_363
    %_365 = getelementptr i8*, i8** %_364, i32 16
    %_366 = load i8*, i8** %_365
    %_367 = bitcast i8* %_366 to i1 (i8*, i8*, i8*)*
    %_368 = load i8*, i8** %p_node
    %_369 = load i8*, i8** %c_node
    %_370 = call i1 %_367(i8* %this, i8* %_368, i8* %_369)
    store i1 %_370, i1* %ntb

    br label %Label45
Label44:
    %_371 = load i8*, i8** %c_node
    %_372 = bitcast i8* %_371 to i8***
    %_373 = load i8**, i8*** %_372
    %_374 = getelementptr i8*, i8** %_373, i32 7
    %_375 = load i8*, i8** %_374
    %_376 = bitcast i8* %_375 to i1 (i8*)*
    %_377 = call i1 %_376(i8* %_371)
    br i1 %_377, label %Label46, label %Label47
Label46:
    %_378 = bitcast i8* %this to i8***
    %_379 = load i8**, i8*** %_378
    %_380 = getelementptr i8*, i8** %_379, i32 15
    %_381 = load i8*, i8** %_380
    %_382 = bitcast i8* %_381 to i1 (i8*, i8*, i8*)*
    %_383 = load i8*, i8** %p_node
    %_384 = load i8*, i8** %c_node
    %_385 = call i1 %_382(i8* %this, i8* %_383, i8* %_384)
    store i1 %_385, i1* %ntb

    br label %Label48
Label47:
    %_386 = load i8*, i8** %c_node
    %_387 = bitcast i8* %_386 to i8***
    %_388 = load i8**, i8*** %_387
    %_389 = getelementptr i8*, i8** %_388, i32 5
    %_390 = load i8*, i8** %_389
    %_391 = bitcast i8* %_390 to i32 (i8*)*
    %_392 = call i32 %_391(i8* %_386)
    store i32 %_392, i32* %auxkey1

    %_393 = load i8*, i8** %p_node
    %_394 = bitcast i8* %_393 to i8***
    %_395 = load i8**, i8*** %_394
    %_396 = getelementptr i8*, i8** %_395, i32 4
    %_397 = load i8*, i8** %_396
    %_398 = bitcast i8* %_397 to i8* (i8*)*
    %_399 = call i8* %_398(i8* %_393)
    %_400 = bitcast i8* %_399 to i8***
    %_401 = load i8**, i8*** %_400
    %_402 = getelementptr i8*, i8** %_401, i32 5
    %_403 = load i8*, i8** %_402
    %_404 = bitcast i8* %_403 to i32 (i8*)*
    %_405 = call i32 %_404(i8* %_399)
    store i32 %_405, i32* %auxkey2

    %_406 = bitcast i8* %this to i8***
    %_407 = load i8**, i8*** %_406
    %_408 = getelementptr i8*, i8** %_407, i32 11
    %_409 = load i8*, i8** %_408
    %_410 = bitcast i8* %_409 to i1 (i8*, i32, i32)*
    %_411 = load i32, i32* %auxkey1
    %_412 = load i32, i32* %auxkey2
    %_413 = call i1 %_410(i8* %this, i32 %_411, i32 %_412)
    br i1 %_413, label %Label49, label %Label50
Label49:
    %_414 = load i8*, i8** %p_node
    %_415 = bitcast i8* %_414 to i8***
    %_416 = load i8**, i8*** %_415
    %_417 = getelementptr i8*, i8** %_416, i32 2
    %_418 = load i8*, i8** %_417
    %_419 = bitcast i8* %_418 to i1 (i8*, i8*)*
    %_420 = getelementptr i8, i8* %this, i32 30
    %_421 = bitcast i8* %_420 to i8**
    %_422 = load i8*, i8** %_421
    %_423 = call i1 %_419(i8* %_414, i8* %_422)
    store i1 %_423, i1* %ntb

    %_424 = load i8*, i8** %p_node
    %_425 = bitcast i8* %_424 to i8***
    %_426 = load i8**, i8*** %_425
    %_427 = getelementptr i8*, i8** %_426, i32 9
    %_428 = load i8*, i8** %_427
    %_429 = bitcast i8* %_428 to i1 (i8*, i1)*
    %_430 = call i1 %_429(i8* %_424, i1 0)
    store i1 %_430, i1* %ntb

    br label %Label51
Label50:
    %_431 = load i8*, i8** %p_node
    %_432 = bitcast i8* %_431 to i8***
    %_433 = load i8**, i8*** %_432
    %_434 = getelementptr i8*, i8** %_433, i32 1
    %_435 = load i8*, i8** %_434
    %_436 = bitcast i8* %_435 to i1 (i8*, i8*)*
    %_437 = getelementptr i8, i8* %this, i32 30
    %_438 = bitcast i8* %_437 to i8**
    %_439 = load i8*, i8** %_438
    %_440 = call i1 %_436(i8* %_431, i8* %_439)
    store i1 %_440, i1* %ntb

    %_441 = load i8*, i8** %p_node
    %_442 = bitcast i8* %_441 to i8***
    %_443 = load i8**, i8*** %_442
    %_444 = getelementptr i8*, i8** %_443, i32 10
    %_445 = load i8*, i8** %_444
    %_446 = bitcast i8* %_445 to i1 (i8*, i1)*
    %_447 = call i1 %_446(i8* %_441, i1 0)
    store i1 %_447, i1* %ntb

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
    %_448 = load i8*, i8** %c_node
    %_449 = bitcast i8* %_448 to i8***
    %_450 = load i8**, i8*** %_449
    %_451 = getelementptr i8*, i8** %_450, i32 7
    %_452 = load i8*, i8** %_451
    %_453 = bitcast i8* %_452 to i1 (i8*)*
    %_454 = call i1 %_453(i8* %_448)
    br i1 %_454, label %Label53, label %Label54
Label53:
    %_455 = load i8*, i8** %c_node
    %_456 = bitcast i8* %_455 to i8***
    %_457 = load i8**, i8*** %_456
    %_458 = getelementptr i8*, i8** %_457, i32 6
    %_459 = load i8*, i8** %_458
    %_460 = bitcast i8* %_459 to i1 (i8*, i32)*
    %_461 = load i8*, i8** %c_node
    %_462 = bitcast i8* %_461 to i8***
    %_463 = load i8**, i8*** %_462
    %_464 = getelementptr i8*, i8** %_463, i32 3
    %_465 = load i8*, i8** %_464
    %_466 = bitcast i8* %_465 to i8* (i8*)*
    %_467 = call i8* %_466(i8* %_461)
    %_468 = bitcast i8* %_467 to i8***
    %_469 = load i8**, i8*** %_468
    %_470 = getelementptr i8*, i8** %_469, i32 5
    %_471 = load i8*, i8** %_470
    %_472 = bitcast i8* %_471 to i32 (i8*)*
    %_473 = call i32 %_472(i8* %_467)
    %_474 = call i1 %_460(i8* %_455, i32 %_473)
    store i1 %_474, i1* %ntb

    %_475 = load i8*, i8** %c_node
    store i8* %_475, i8** %p_node

    %_476 = load i8*, i8** %c_node
    %_477 = bitcast i8* %_476 to i8***
    %_478 = load i8**, i8*** %_477
    %_479 = getelementptr i8*, i8** %_478, i32 3
    %_480 = load i8*, i8** %_479
    %_481 = bitcast i8* %_480 to i8* (i8*)*
    %_482 = call i8* %_481(i8* %_476)
    store i8* %_482, i8** %c_node

    br label %Label52
Label54:

    %_483 = load i8*, i8** %p_node
    %_484 = bitcast i8* %_483 to i8***
    %_485 = load i8**, i8*** %_484
    %_486 = getelementptr i8*, i8** %_485, i32 1
    %_487 = load i8*, i8** %_486
    %_488 = bitcast i8* %_487 to i1 (i8*, i8*)*
    %_489 = getelementptr i8, i8* %this, i32 30
    %_490 = bitcast i8* %_489 to i8**
    %_491 = load i8*, i8** %_490
    %_492 = call i1 %_488(i8* %_483, i8* %_491)
    store i1 %_492, i1* %ntb

    %_493 = load i8*, i8** %p_node
    %_494 = bitcast i8* %_493 to i8***
    %_495 = load i8**, i8*** %_494
    %_496 = getelementptr i8*, i8** %_495, i32 10
    %_497 = load i8*, i8** %_496
    %_498 = bitcast i8* %_497 to i1 (i8*, i1)*
    %_499 = call i1 %_498(i8* %_493, i1 0)
    store i1 %_499, i1* %ntb

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
    %_500 = load i8*, i8** %c_node
    %_501 = bitcast i8* %_500 to i8***
    %_502 = load i8**, i8*** %_501
    %_503 = getelementptr i8*, i8** %_502, i32 8
    %_504 = load i8*, i8** %_503
    %_505 = bitcast i8* %_504 to i1 (i8*)*
    %_506 = call i1 %_505(i8* %_500)
    br i1 %_506, label %Label56, label %Label57
Label56:
    %_507 = load i8*, i8** %c_node
    %_508 = bitcast i8* %_507 to i8***
    %_509 = load i8**, i8*** %_508
    %_510 = getelementptr i8*, i8** %_509, i32 6
    %_511 = load i8*, i8** %_510
    %_512 = bitcast i8* %_511 to i1 (i8*, i32)*
    %_513 = load i8*, i8** %c_node
    %_514 = bitcast i8* %_513 to i8***
    %_515 = load i8**, i8*** %_514
    %_516 = getelementptr i8*, i8** %_515, i32 4
    %_517 = load i8*, i8** %_516
    %_518 = bitcast i8* %_517 to i8* (i8*)*
    %_519 = call i8* %_518(i8* %_513)
    %_520 = bitcast i8* %_519 to i8***
    %_521 = load i8**, i8*** %_520
    %_522 = getelementptr i8*, i8** %_521, i32 5
    %_523 = load i8*, i8** %_522
    %_524 = bitcast i8* %_523 to i32 (i8*)*
    %_525 = call i32 %_524(i8* %_519)
    %_526 = call i1 %_512(i8* %_507, i32 %_525)
    store i1 %_526, i1* %ntb

    %_527 = load i8*, i8** %c_node
    store i8* %_527, i8** %p_node

    %_528 = load i8*, i8** %c_node
    %_529 = bitcast i8* %_528 to i8***
    %_530 = load i8**, i8*** %_529
    %_531 = getelementptr i8*, i8** %_530, i32 4
    %_532 = load i8*, i8** %_531
    %_533 = bitcast i8* %_532 to i8* (i8*)*
    %_534 = call i8* %_533(i8* %_528)
    store i8* %_534, i8** %c_node

    br label %Label55
Label57:

    %_535 = load i8*, i8** %p_node
    %_536 = bitcast i8* %_535 to i8***
    %_537 = load i8**, i8*** %_536
    %_538 = getelementptr i8*, i8** %_537, i32 2
    %_539 = load i8*, i8** %_538
    %_540 = bitcast i8* %_539 to i1 (i8*, i8*)*
    %_541 = getelementptr i8, i8* %this, i32 30
    %_542 = bitcast i8* %_541 to i8**
    %_543 = load i8*, i8** %_542
    %_544 = call i1 %_540(i8* %_535, i8* %_543)
    store i1 %_544, i1* %ntb

    %_545 = load i8*, i8** %p_node
    %_546 = bitcast i8* %_545 to i8***
    %_547 = load i8**, i8*** %_546
    %_548 = getelementptr i8*, i8** %_547, i32 9
    %_549 = load i8*, i8** %_548
    %_550 = bitcast i8* %_549 to i1 (i8*, i1)*
    %_551 = call i1 %_550(i8* %_545, i1 0)
    store i1 %_551, i1* %ntb

    ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key

    %current_node = alloca i8*

    %ifound = alloca i32

    %cont = alloca i1

    %key_aux = alloca i32

    store i8* %this, i8** %current_node

    store i1 1, i1* %cont

    store i32 0, i32* %ifound

    br label %Label58
Label58:
    %_552 = load i1, i1* %cont
    br i1 %_552, label %Label59, label %Label60
Label59:
    %_553 = load i8*, i8** %current_node
    %_554 = bitcast i8* %_553 to i8***
    %_555 = load i8**, i8*** %_554
    %_556 = getelementptr i8*, i8** %_555, i32 5
    %_557 = load i8*, i8** %_556
    %_558 = bitcast i8* %_557 to i32 (i8*)*
    %_559 = call i32 %_558(i8* %_553)
    store i32 %_559, i32* %key_aux

    %_561 = load i32, i32* %v_key
    %_562 = load i32, i32* %key_aux
    %_560 = icmp slt i32 %_561, %_562
    br i1 %_560, label %Label61, label %Label62
Label61:
    %_563 = load i8*, i8** %current_node
    %_564 = bitcast i8* %_563 to i8***
    %_565 = load i8**, i8*** %_564
    %_566 = getelementptr i8*, i8** %_565, i32 8
    %_567 = load i8*, i8** %_566
    %_568 = bitcast i8* %_567 to i1 (i8*)*
    %_569 = call i1 %_568(i8* %_563)
    br i1 %_569, label %Label64, label %Label65
Label64:
    %_570 = load i8*, i8** %current_node
    %_571 = bitcast i8* %_570 to i8***
    %_572 = load i8**, i8*** %_571
    %_573 = getelementptr i8*, i8** %_572, i32 4
    %_574 = load i8*, i8** %_573
    %_575 = bitcast i8* %_574 to i8* (i8*)*
    %_576 = call i8* %_575(i8* %_570)
    store i8* %_576, i8** %current_node

    br label %Label66
Label65:
    store i1 0, i1* %cont

    br label %Label66
Label66:

    br label %Label63
Label62:
    %_578 = load i32, i32* %key_aux
    %_579 = load i32, i32* %v_key
    %_577 = icmp slt i32 %_578, %_579
    br i1 %_577, label %Label67, label %Label68
Label67:
    %_580 = load i8*, i8** %current_node
    %_581 = bitcast i8* %_580 to i8***
    %_582 = load i8**, i8*** %_581
    %_583 = getelementptr i8*, i8** %_582, i32 7
    %_584 = load i8*, i8** %_583
    %_585 = bitcast i8* %_584 to i1 (i8*)*
    %_586 = call i1 %_585(i8* %_580)
    br i1 %_586, label %Label70, label %Label71
Label70:
    %_587 = load i8*, i8** %current_node
    %_588 = bitcast i8* %_587 to i8***
    %_589 = load i8**, i8*** %_588
    %_590 = getelementptr i8*, i8** %_589, i32 3
    %_591 = load i8*, i8** %_590
    %_592 = bitcast i8* %_591 to i8* (i8*)*
    %_593 = call i8* %_592(i8* %_587)
    store i8* %_593, i8** %current_node

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

    %_594 = load i32, i32* %ifound
    ret i32 %_594
}

define i1 @Tree.Print(i8* %this) {
    %ntb = alloca i1

    %current_node = alloca i8*

    store i8* %this, i8** %current_node

    %_595 = bitcast i8* %this to i8***
    %_596 = load i8**, i8*** %_595
    %_597 = getelementptr i8*, i8** %_596, i32 19
    %_598 = load i8*, i8** %_597
    %_599 = bitcast i8* %_598 to i1 (i8*, i8*)*
    %_600 = load i8*, i8** %current_node
    %_601 = call i1 %_599(i8* %this, i8* %_600)
    store i1 %_601, i1* %ntb

    ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
    %node = alloca i8*
    store i8* %.node, i8** %node

    %ntb = alloca i1

    %_602 = load i8*, i8** %node
    %_603 = bitcast i8* %_602 to i8***
    %_604 = load i8**, i8*** %_603
    %_605 = getelementptr i8*, i8** %_604, i32 8
    %_606 = load i8*, i8** %_605
    %_607 = bitcast i8* %_606 to i1 (i8*)*
    %_608 = call i1 %_607(i8* %_602)
    br i1 %_608, label %Label73, label %Label74
Label73:
    %_609 = bitcast i8* %this to i8***
    %_610 = load i8**, i8*** %_609
    %_611 = getelementptr i8*, i8** %_610, i32 19
    %_612 = load i8*, i8** %_611
    %_613 = bitcast i8* %_612 to i1 (i8*, i8*)*
    %_614 = load i8*, i8** %node
    %_615 = bitcast i8* %_614 to i8***
    %_616 = load i8**, i8*** %_615
    %_617 = getelementptr i8*, i8** %_616, i32 4
    %_618 = load i8*, i8** %_617
    %_619 = bitcast i8* %_618 to i8* (i8*)*
    %_620 = call i8* %_619(i8* %_614)
    %_621 = call i1 %_613(i8* %this, i8* %_620)
    store i1 %_621, i1* %ntb

    br label %Label75
Label74:
    store i1 1, i1* %ntb

    br label %Label75
Label75:

    %_622 = load i8*, i8** %node
    %_623 = bitcast i8* %_622 to i8***
    %_624 = load i8**, i8*** %_623
    %_625 = getelementptr i8*, i8** %_624, i32 5
    %_626 = load i8*, i8** %_625
    %_627 = bitcast i8* %_626 to i32 (i8*)*
    %_628 = call i32 %_627(i8* %_622)
    call void @print_int(i32 %_628)
    %_629 = load i8*, i8** %node
    %_630 = bitcast i8* %_629 to i8***
    %_631 = load i8**, i8*** %_630
    %_632 = getelementptr i8*, i8** %_631, i32 7
    %_633 = load i8*, i8** %_632
    %_634 = bitcast i8* %_633 to i1 (i8*)*
    %_635 = call i1 %_634(i8* %_629)
    br i1 %_635, label %Label76, label %Label77
Label76:
    %_636 = bitcast i8* %this to i8***
    %_637 = load i8**, i8*** %_636
    %_638 = getelementptr i8*, i8** %_637, i32 19
    %_639 = load i8*, i8** %_638
    %_640 = bitcast i8* %_639 to i1 (i8*, i8*)*
    %_641 = load i8*, i8** %node
    %_642 = bitcast i8* %_641 to i8***
    %_643 = load i8**, i8*** %_642
    %_644 = getelementptr i8*, i8** %_643, i32 3
    %_645 = load i8*, i8** %_644
    %_646 = bitcast i8* %_645 to i8* (i8*)*
    %_647 = call i8* %_646(i8* %_641)
    %_648 = call i1 %_640(i8* %this, i8* %_647)
    store i1 %_648, i1* %ntb

    br label %Label78
Label77:
    store i1 1, i1* %ntb

    br label %Label78
Label78:

    ret i1 1
}

define i32 @Tree.accept(i8* %this, i8* %.v) {
    %v = alloca i8*
    store i8* %.v, i8** %v

    %nti = alloca i32

    call void @print_int(i32 333)
    %_649 = load i8*, i8** %v
    %_650 = bitcast i8* %_649 to i8***
    %_651 = load i8**, i8*** %_650
    %_652 = getelementptr i8*, i8** %_651, i32 0
    %_653 = load i8*, i8** %_652
    %_654 = bitcast i8* %_653 to i32 (i8*, i8*)*
    %_655 = call i32 %_654(i8* %_649, i8* %this)
    store i32 %_655, i32* %nti

    ret i32 0
}

define i32 @Visitor.visit(i8* %this, i8* %.n) {
    %n = alloca i8*
    store i8* %.n, i8** %n

    %nti = alloca i32

    %_656 = load i8*, i8** %n
    %_657 = bitcast i8* %_656 to i8***
    %_658 = load i8**, i8*** %_657
    %_659 = getelementptr i8*, i8** %_658, i32 7
    %_660 = load i8*, i8** %_659
    %_661 = bitcast i8* %_660 to i1 (i8*)*
    %_662 = call i1 %_661(i8* %_656)
    br i1 %_662, label %Label79, label %Label80
Label79:
    %_663 = getelementptr i8, i8* %this, i32 16
    %_664 = bitcast i8* %_663 to i8**
    %_665 = load i8*, i8** %n
    %_666 = bitcast i8* %_665 to i8***
    %_667 = load i8**, i8*** %_666
    %_668 = getelementptr i8*, i8** %_667, i32 3
    %_669 = load i8*, i8** %_668
    %_670 = bitcast i8* %_669 to i8* (i8*)*
    %_671 = call i8* %_670(i8* %_665)
    store i8* %_671, i8** %_664
    %_672 = getelementptr i8, i8* %this, i32 16
    %_673 = bitcast i8* %_672 to i8**
    %_674 = load i8*, i8** %_673
    %_675 = bitcast i8* %_674 to i8***
    %_676 = load i8**, i8*** %_675
    %_677 = getelementptr i8*, i8** %_676, i32 20
    %_678 = load i8*, i8** %_677
    %_679 = bitcast i8* %_678 to i32 (i8*, i8*)*
    %_680 = call i32 %_679(i8* %_674, i8* %this)
    store i32 %_680, i32* %nti

    br label %Label81
Label80:
    store i32 0, i32* %nti

    br label %Label81
Label81:

    %_681 = load i8*, i8** %n
    %_682 = bitcast i8* %_681 to i8***
    %_683 = load i8**, i8*** %_682
    %_684 = getelementptr i8*, i8** %_683, i32 8
    %_685 = load i8*, i8** %_684
    %_686 = bitcast i8* %_685 to i1 (i8*)*
    %_687 = call i1 %_686(i8* %_681)
    br i1 %_687, label %Label82, label %Label83
Label82:
    %_688 = getelementptr i8, i8* %this, i32 8
    %_689 = bitcast i8* %_688 to i8**
    %_690 = load i8*, i8** %n
    %_691 = bitcast i8* %_690 to i8***
    %_692 = load i8**, i8*** %_691
    %_693 = getelementptr i8*, i8** %_692, i32 4
    %_694 = load i8*, i8** %_693
    %_695 = bitcast i8* %_694 to i8* (i8*)*
    %_696 = call i8* %_695(i8* %_690)
    store i8* %_696, i8** %_689
    %_697 = getelementptr i8, i8* %this, i32 8
    %_698 = bitcast i8* %_697 to i8**
    %_699 = load i8*, i8** %_698
    %_700 = bitcast i8* %_699 to i8***
    %_701 = load i8**, i8*** %_700
    %_702 = getelementptr i8*, i8** %_701, i32 20
    %_703 = load i8*, i8** %_702
    %_704 = bitcast i8* %_703 to i32 (i8*, i8*)*
    %_705 = call i32 %_704(i8* %_699, i8* %this)
    store i32 %_705, i32* %nti

    br label %Label84
Label83:
    store i32 0, i32* %nti

    br label %Label84
Label84:

    ret i32 0
}

define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
    %n = alloca i8*
    store i8* %.n, i8** %n

    %nti = alloca i32

    %_706 = load i8*, i8** %n
    %_707 = bitcast i8* %_706 to i8***
    %_708 = load i8**, i8*** %_707
    %_709 = getelementptr i8*, i8** %_708, i32 7
    %_710 = load i8*, i8** %_709
    %_711 = bitcast i8* %_710 to i1 (i8*)*
    %_712 = call i1 %_711(i8* %_706)
    br i1 %_712, label %Label85, label %Label86
Label85:
    %_713 = getelementptr i8, i8* %this, i32 16
    %_714 = bitcast i8* %_713 to i8**
    %_715 = load i8*, i8** %n
    %_716 = bitcast i8* %_715 to i8***
    %_717 = load i8**, i8*** %_716
    %_718 = getelementptr i8*, i8** %_717, i32 3
    %_719 = load i8*, i8** %_718
    %_720 = bitcast i8* %_719 to i8* (i8*)*
    %_721 = call i8* %_720(i8* %_715)
    store i8* %_721, i8** %_714
    %_722 = getelementptr i8, i8* %this, i32 16
    %_723 = bitcast i8* %_722 to i8**
    %_724 = load i8*, i8** %_723
    %_725 = bitcast i8* %_724 to i8***
    %_726 = load i8**, i8*** %_725
    %_727 = getelementptr i8*, i8** %_726, i32 20
    %_728 = load i8*, i8** %_727
    %_729 = bitcast i8* %_728 to i32 (i8*, i8*)*
    %_730 = call i32 %_729(i8* %_724, i8* %this)
    store i32 %_730, i32* %nti

    br label %Label87
Label86:
    store i32 0, i32* %nti

    br label %Label87
Label87:

    %_731 = load i8*, i8** %n
    %_732 = bitcast i8* %_731 to i8***
    %_733 = load i8**, i8*** %_732
    %_734 = getelementptr i8*, i8** %_733, i32 5
    %_735 = load i8*, i8** %_734
    %_736 = bitcast i8* %_735 to i32 (i8*)*
    %_737 = call i32 %_736(i8* %_731)
    call void @print_int(i32 %_737)
    %_738 = load i8*, i8** %n
    %_739 = bitcast i8* %_738 to i8***
    %_740 = load i8**, i8*** %_739
    %_741 = getelementptr i8*, i8** %_740, i32 8
    %_742 = load i8*, i8** %_741
    %_743 = bitcast i8* %_742 to i1 (i8*)*
    %_744 = call i1 %_743(i8* %_738)
    br i1 %_744, label %Label88, label %Label89
Label88:
    %_745 = getelementptr i8, i8* %this, i32 8
    %_746 = bitcast i8* %_745 to i8**
    %_747 = load i8*, i8** %n
    %_748 = bitcast i8* %_747 to i8***
    %_749 = load i8**, i8*** %_748
    %_750 = getelementptr i8*, i8** %_749, i32 4
    %_751 = load i8*, i8** %_750
    %_752 = bitcast i8* %_751 to i8* (i8*)*
    %_753 = call i8* %_752(i8* %_747)
    store i8* %_753, i8** %_746
    %_754 = getelementptr i8, i8* %this, i32 8
    %_755 = bitcast i8* %_754 to i8**
    %_756 = load i8*, i8** %_755
    %_757 = bitcast i8* %_756 to i8***
    %_758 = load i8**, i8*** %_757
    %_759 = getelementptr i8*, i8** %_758, i32 20
    %_760 = load i8*, i8** %_759
    %_761 = bitcast i8* %_760 to i32 (i8*, i8*)*
    %_762 = call i32 %_761(i8* %_756, i8* %this)
    store i32 %_762, i32* %nti

    br label %Label90
Label89:
    store i32 0, i32* %nti

    br label %Label90
Label90:

    ret i32 0
}
