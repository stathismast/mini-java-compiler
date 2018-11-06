@.LinkedList_vtable = global [0 x i8*] []
@.LL_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @LL.Start to i8*)]
@.Element_vtable = global [6 x i8*] [i8* bitcast (i1 (i8*, i32, i32, i1)* @Element.Init to i8*), i8* bitcast (i32 (i8*)* @Element.GetAge to i8*), i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*), i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*), i8* bitcast (i1 (i8*, i8*)* @Element.Equal to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Element.Compare to i8*)]
@.List_vtable = global [10 x i8*] [i8* bitcast (i1 (i8*)* @List.Init to i8*), i8* bitcast (i1 (i8*, i8*, i8*, i1)* @List.InitNew to i8*), i8* bitcast (i8* (i8*, i8*)* @List.Insert to i8*), i8* bitcast (i1 (i8*, i8*)* @List.SetNext to i8*), i8* bitcast (i8* (i8*, i8*)* @List.Delete to i8*), i8* bitcast (i32 (i8*, i8*)* @List.Search to i8*), i8* bitcast (i1 (i8*)* @List.GetEnd to i8*), i8* bitcast (i8* (i8*)* @List.GetElem to i8*), i8* bitcast (i8* (i8*)* @List.GetNext to i8*), i8* bitcast (i1 (i8*)* @List.Print to i8*)]

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
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
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

define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
    %v_Age = alloca i32
    store i32 %.v_Age, i32* %v_Age

    %v_Salary = alloca i32
    store i32 %.v_Salary, i32* %v_Salary

    %v_Married = alloca i1
    store i1 %.v_Married, i1* %v_Married

    %_9 = getelementptr i8, i8* %this, i32 8
    %_10 = bitcast i8* %_9 to i32*
    %_11 = load i32, i32* %v_Age
    store i32 %_11, i32* %_10
    %_12 = getelementptr i8, i8* %this, i32 12
    %_13 = bitcast i8* %_12 to i32*
    %_14 = load i32, i32* %v_Salary
    store i32 %_14, i32* %_13
    %_15 = getelementptr i8, i8* %this, i32 16
    %_16 = bitcast i8* %_15 to i1*
    %_17 = load i1, i1* %v_Married
    store i1 %_17, i1* %_16
    ret i1 1
}

define i32 @Element.GetAge(i8* %this) {
    %_18 = getelementptr i8, i8* %this, i32 8
    %_19 = bitcast i8* %_18 to i32*
    %_20 = load i32, i32* %_19
    ret i32 %_20
}

define i32 @Element.GetSalary(i8* %this) {
    %_21 = getelementptr i8, i8* %this, i32 12
    %_22 = bitcast i8* %_21 to i32*
    %_23 = load i32, i32* %_22
    ret i32 %_23
}

define i1 @Element.GetMarried(i8* %this) {
    %_24 = getelementptr i8, i8* %this, i32 16
    %_25 = bitcast i8* %_24 to i1*
    %_26 = load i1, i1* %_25
    ret i1 %_26
}

define i1 @Element.Equal(i8* %this, i8* %.other) {
    %other = alloca i8*
    store i8* %.other, i8** %other

    %ret_val = alloca i1

    %aux01 = alloca i32

    %aux02 = alloca i32

    %nt = alloca i32

    store i1 1, i1* %ret_val

    %_27 = load i8*, i8** %other
    %_28 = bitcast i8* %_27 to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = getelementptr i8*, i8** %_29, i32 1
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32 (i8*)*
    %_33 = call i32 %_32(i8* %_27)
    store i32 %_33, i32* %aux01

    %_35 = bitcast i8* %this to i8***
    %_36 = load i8**, i8*** %_35
    %_37 = getelementptr i8*, i8** %_36, i32 5
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i1 (i8*, i32, i32)*
    %_40 = load i32, i32* %aux01
    %_41 = getelementptr i8, i8* %this, i32 8
    %_42 = bitcast i8* %_41 to i32*
    %_43 = load i32, i32* %_42
    %_44 = call i1 %_39(i8* %this, i32 %_40, i32 %_43)
    %_34 = add i1 %_44, 1
    br i1 %_34, label %Label0, label %Label1
Label0:
    store i1 0, i1* %ret_val

    br label %Label2
Label1:
    %_45 = load i8*, i8** %other
    %_46 = bitcast i8* %_45 to i8***
    %_47 = load i8**, i8*** %_46
    %_48 = getelementptr i8*, i8** %_47, i32 2
    %_49 = load i8*, i8** %_48
    %_50 = bitcast i8* %_49 to i32 (i8*)*
    %_51 = call i32 %_50(i8* %_45)
    store i32 %_51, i32* %aux02

    %_53 = bitcast i8* %this to i8***
    %_54 = load i8**, i8*** %_53
    %_55 = getelementptr i8*, i8** %_54, i32 5
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i1 (i8*, i32, i32)*
    %_58 = load i32, i32* %aux02
    %_59 = getelementptr i8, i8* %this, i32 12
    %_60 = bitcast i8* %_59 to i32*
    %_61 = load i32, i32* %_60
    %_62 = call i1 %_57(i8* %this, i32 %_58, i32 %_61)
    %_52 = add i1 %_62, 1
    br i1 %_52, label %Label3, label %Label4
Label3:
    store i1 0, i1* %ret_val

    br label %Label5
Label4:
    %_63 = getelementptr i8, i8* %this, i32 16
    %_64 = bitcast i8* %_63 to i1*
    %_65 = load i1, i1* %_64
    br i1 %_65, label %Label6, label %Label7
Label6:
    %_67 = load i8*, i8** %other
    %_68 = bitcast i8* %_67 to i8***
    %_69 = load i8**, i8*** %_68
    %_70 = getelementptr i8*, i8** %_69, i32 3
    %_71 = load i8*, i8** %_70
    %_72 = bitcast i8* %_71 to i1 (i8*)*
    %_73 = call i1 %_72(i8* %_67)
    %_66 = add i1 %_73, 1
    br i1 %_66, label %Label9, label %Label10
Label9:
    store i1 0, i1* %ret_val

    br label %Label11
Label10:
    store i32 0, i32* %nt

    br label %Label11
Label11:

    br label %Label8
Label7:
    %_74 = load i8*, i8** %other
    %_75 = bitcast i8* %_74 to i8***
    %_76 = load i8**, i8*** %_75
    %_77 = getelementptr i8*, i8** %_76, i32 3
    %_78 = load i8*, i8** %_77
    %_79 = bitcast i8* %_78 to i1 (i8*)*
    %_80 = call i1 %_79(i8* %_74)
    br i1 %_80, label %Label12, label %Label13
Label12:
    store i1 0, i1* %ret_val

    br label %Label14
Label13:
    store i32 0, i32* %nt

    br label %Label14
Label14:

    br label %Label8
Label8:

    br label %Label5
Label5:

    br label %Label2
Label2:

    %_81 = load i1, i1* %ret_val
    ret i1 %_81
}

define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1

    %num2 = alloca i32
    store i32 %.num2, i32* %num2

    %retval = alloca i1

    %aux02 = alloca i32

    store i1 0, i1* %retval

    %_83 = load i32, i32* %num2
    %_82 = add i32 %_83, 1
    store i32 %_82, i32* %aux02

    %_85 = load i32, i32* %num1
    %_86 = load i32, i32* %num2
    %_84 = icmp slt i32 %_85, %_86
    br i1 %_84, label %Label15, label %Label16
Label15:
    store i1 0, i1* %retval

    br label %Label17
Label16:
    %_89 = load i32, i32* %num1
    %_90 = load i32, i32* %aux02
    %_88 = icmp slt i32 %_89, %_90
    %_87 = add i1 %_88, 1
    br i1 %_87, label %Label18, label %Label19
Label18:
    store i1 0, i1* %retval

    br label %Label20
Label19:
    store i1 1, i1* %retval

    br label %Label20
Label20:

    br label %Label17
Label17:

    %_91 = load i1, i1* %retval
    ret i1 %_91
}

define i1 @List.Init(i8* %this) {
    %_92 = getelementptr i8, i8* %this, i32 24
    %_93 = bitcast i8* %_92 to i1*
    store i1 1, i1* %_93
    ret i1 1
}

define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
    %v_elem = alloca i8*
    store i8* %.v_elem, i8** %v_elem

    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next

    %v_end = alloca i1
    store i1 %.v_end, i1* %v_end

    %_94 = getelementptr i8, i8* %this, i32 24
    %_95 = bitcast i8* %_94 to i1*
    %_96 = load i1, i1* %v_end
    store i1 %_96, i1* %_95
    %_97 = getelementptr i8, i8* %this, i32 8
    %_98 = bitcast i8* %_97 to i8**
    %_99 = load i8*, i8** %v_elem
    store i8* %_99, i8** %_98
    %_100 = getelementptr i8, i8* %this, i32 16
    %_101 = bitcast i8* %_100 to i8**
    %_102 = load i8*, i8** %v_next
    store i8* %_102, i8** %_101
    ret i1 1
}

define i8* @List.Insert(i8* %this, i8* %.new_elem) {
    %new_elem = alloca i8*
    store i8* %.new_elem, i8** %new_elem

    %ret_val = alloca i1

    %aux03 = alloca i8*

    %aux02 = alloca i8*

    store i8* %this, i8** %aux03

    %_103 = call i8* @calloc(i32 1, i32 25)
    %_104 = bitcast i8* %_103 to i8***
    %_105 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    store i8** %_105, i8*** %_104
    store i8* %_103, i8** %aux02

    %_106 = load i8*, i8** %aux02
    %_107 = bitcast i8* %_106 to i8***
    %_108 = load i8**, i8*** %_107
    %_109 = getelementptr i8*, i8** %_108, i32 1
    %_110 = load i8*, i8** %_109
    %_111 = bitcast i8* %_110 to i1 (i8*, i8*, i8*, i1)*
    %_112 = load i8*, i8** %new_elem
    %_113 = load i8*, i8** %aux03
    %_114 = call i1 %_111(i8* %_106, i8* %_112, i8* %_113, i1 0)
    store i1 %_114, i1* %ret_val

    %_115 = load i8*, i8** %aux02
    ret i8* %_115
}

define i1 @List.SetNext(i8* %this, i8* %.v_next) {
    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next

    %_116 = getelementptr i8, i8* %this, i32 16
    %_117 = bitcast i8* %_116 to i8**
    %_118 = load i8*, i8** %v_next
    store i8* %_118, i8** %_117
    ret i1 1
}

define i8* @List.Delete(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e

    %my_head = alloca i8*

    %ret_val = alloca i1

    %aux05 = alloca i1

    %aux01 = alloca i8*

    %prev = alloca i8*

    %var_end = alloca i1

    %var_elem = alloca i8*

    %aux04 = alloca i32

    %nt = alloca i32

    store i8* %this, i8** %my_head

    store i1 0, i1* %ret_val

    %_119 = sub i32 0, 1
    store i32 %_119, i32* %aux04

    store i8* %this, i8** %aux01

    store i8* %this, i8** %prev

    %_120 = getelementptr i8, i8* %this, i32 24
    %_121 = bitcast i8* %_120 to i1*
    %_122 = load i1, i1* %_121
    store i1 %_122, i1* %var_end

    %_123 = getelementptr i8, i8* %this, i32 8
    %_124 = bitcast i8* %_123 to i8**
    %_125 = load i8*, i8** %_124
    store i8* %_125, i8** %var_elem

    br label %Label21
Label21:
    %_126 = alloca i1
    %_128 = load i1, i1* %var_end
    %_127 = add i1 %_128, 1
    br i1 %_127, label %Label25, label %Label26
Label25:
    %_130 = load i1, i1* %ret_val
    %_129 = add i1 %_130, 1
    br i1 %_129, label %Label24, label %Label26
Label24:
    store i1 1 , i1* %_126
    br label %Label27
Label26:
    store i1 0 , i1* %_126
    br label %Label27
Label27:
    %_131 = load i1, i1* %_126
    br i1 %_131, label %Label22, label %Label23
Label22:
    %_132 = load i8*, i8** %e
    %_133 = bitcast i8* %_132 to i8***
    %_134 = load i8**, i8*** %_133
    %_135 = getelementptr i8*, i8** %_134, i32 4
    %_136 = load i8*, i8** %_135
    %_137 = bitcast i8* %_136 to i1 (i8*, i8*)*
    %_138 = load i8*, i8** %var_elem
    %_139 = call i1 %_137(i8* %_132, i8* %_138)
    br i1 %_139, label %Label28, label %Label29
Label28:
    store i1 1, i1* %ret_val

    %_141 = load i32, i32* %aux04
    %_140 = icmp slt i32 %_141, 0
    br i1 %_140, label %Label31, label %Label32
Label31:
    %_142 = load i8*, i8** %aux01
    %_143 = bitcast i8* %_142 to i8***
    %_144 = load i8**, i8*** %_143
    %_145 = getelementptr i8*, i8** %_144, i32 8
    %_146 = load i8*, i8** %_145
    %_147 = bitcast i8* %_146 to i8* (i8*)*
    %_148 = call i8* %_147(i8* %_142)
    store i8* %_148, i8** %my_head

    br label %Label33
Label32:
    %_149 = sub i32 0, 555
    call void @print_int(i32 %_149)
    %_150 = load i8*, i8** %prev
    %_151 = bitcast i8* %_150 to i8***
    %_152 = load i8**, i8*** %_151
    %_153 = getelementptr i8*, i8** %_152, i32 3
    %_154 = load i8*, i8** %_153
    %_155 = bitcast i8* %_154 to i1 (i8*, i8*)*
    %_156 = load i8*, i8** %aux01
    %_157 = bitcast i8* %_156 to i8***
    %_158 = load i8**, i8*** %_157
    %_159 = getelementptr i8*, i8** %_158, i32 8
    %_160 = load i8*, i8** %_159
    %_161 = bitcast i8* %_160 to i8* (i8*)*
    %_162 = call i8* %_161(i8* %_156)
    %_163 = call i1 %_155(i8* %_150, i8* %_162)
    store i1 %_163, i1* %aux05

    %_164 = sub i32 0, 555
    call void @print_int(i32 %_164)
    br label %Label33
Label33:

    br label %Label30
Label29:
    store i32 0, i32* %nt

    br label %Label30
Label30:

    %_166 = load i1, i1* %ret_val
    %_165 = add i1 %_166, 1
    br i1 %_165, label %Label34, label %Label35
Label34:
    %_167 = load i8*, i8** %aux01
    store i8* %_167, i8** %prev

    %_168 = load i8*, i8** %aux01
    %_169 = bitcast i8* %_168 to i8***
    %_170 = load i8**, i8*** %_169
    %_171 = getelementptr i8*, i8** %_170, i32 8
    %_172 = load i8*, i8** %_171
    %_173 = bitcast i8* %_172 to i8* (i8*)*
    %_174 = call i8* %_173(i8* %_168)
    store i8* %_174, i8** %aux01

    %_175 = load i8*, i8** %aux01
    %_176 = bitcast i8* %_175 to i8***
    %_177 = load i8**, i8*** %_176
    %_178 = getelementptr i8*, i8** %_177, i32 6
    %_179 = load i8*, i8** %_178
    %_180 = bitcast i8* %_179 to i1 (i8*)*
    %_181 = call i1 %_180(i8* %_175)
    store i1 %_181, i1* %var_end

    %_182 = load i8*, i8** %aux01
    %_183 = bitcast i8* %_182 to i8***
    %_184 = load i8**, i8*** %_183
    %_185 = getelementptr i8*, i8** %_184, i32 7
    %_186 = load i8*, i8** %_185
    %_187 = bitcast i8* %_186 to i8* (i8*)*
    %_188 = call i8* %_187(i8* %_182)
    store i8* %_188, i8** %var_elem

    store i32 1, i32* %aux04

    br label %Label36
Label35:
    store i32 0, i32* %nt

    br label %Label36
Label36:

    br label %Label21
Label23:

    %_189 = load i8*, i8** %my_head
    ret i8* %_189
}

define i32 @List.Search(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e

    %int_ret_val = alloca i32

    %aux01 = alloca i8*

    %var_elem = alloca i8*

    %var_end = alloca i1

    %nt = alloca i32

    store i32 0, i32* %int_ret_val

    store i8* %this, i8** %aux01

    %_190 = getelementptr i8, i8* %this, i32 24
    %_191 = bitcast i8* %_190 to i1*
    %_192 = load i1, i1* %_191
    store i1 %_192, i1* %var_end

    %_193 = getelementptr i8, i8* %this, i32 8
    %_194 = bitcast i8* %_193 to i8**
    %_195 = load i8*, i8** %_194
    store i8* %_195, i8** %var_elem

    br label %Label37
Label37:
    %_197 = load i1, i1* %var_end
    %_196 = add i1 %_197, 1
    br i1 %_196, label %Label38, label %Label39
Label38:
    %_198 = load i8*, i8** %e
    %_199 = bitcast i8* %_198 to i8***
    %_200 = load i8**, i8*** %_199
    %_201 = getelementptr i8*, i8** %_200, i32 4
    %_202 = load i8*, i8** %_201
    %_203 = bitcast i8* %_202 to i1 (i8*, i8*)*
    %_204 = load i8*, i8** %var_elem
    %_205 = call i1 %_203(i8* %_198, i8* %_204)
    br i1 %_205, label %Label40, label %Label41
Label40:
    store i32 1, i32* %int_ret_val

    br label %Label42
Label41:
    store i32 0, i32* %nt

    br label %Label42
Label42:

    %_206 = load i8*, i8** %aux01
    %_207 = bitcast i8* %_206 to i8***
    %_208 = load i8**, i8*** %_207
    %_209 = getelementptr i8*, i8** %_208, i32 8
    %_210 = load i8*, i8** %_209
    %_211 = bitcast i8* %_210 to i8* (i8*)*
    %_212 = call i8* %_211(i8* %_206)
    store i8* %_212, i8** %aux01

    %_213 = load i8*, i8** %aux01
    %_214 = bitcast i8* %_213 to i8***
    %_215 = load i8**, i8*** %_214
    %_216 = getelementptr i8*, i8** %_215, i32 6
    %_217 = load i8*, i8** %_216
    %_218 = bitcast i8* %_217 to i1 (i8*)*
    %_219 = call i1 %_218(i8* %_213)
    store i1 %_219, i1* %var_end

    %_220 = load i8*, i8** %aux01
    %_221 = bitcast i8* %_220 to i8***
    %_222 = load i8**, i8*** %_221
    %_223 = getelementptr i8*, i8** %_222, i32 7
    %_224 = load i8*, i8** %_223
    %_225 = bitcast i8* %_224 to i8* (i8*)*
    %_226 = call i8* %_225(i8* %_220)
    store i8* %_226, i8** %var_elem

    br label %Label37
Label39:

    %_227 = load i32, i32* %int_ret_val
    ret i32 %_227
}

define i1 @List.GetEnd(i8* %this) {
    %_228 = getelementptr i8, i8* %this, i32 24
    %_229 = bitcast i8* %_228 to i1*
    %_230 = load i1, i1* %_229
    ret i1 %_230
}

define i8* @List.GetElem(i8* %this) {
    %_231 = getelementptr i8, i8* %this, i32 8
    %_232 = bitcast i8* %_231 to i8**
    %_233 = load i8*, i8** %_232
    ret i8* %_233
}

define i8* @List.GetNext(i8* %this) {
    %_234 = getelementptr i8, i8* %this, i32 16
    %_235 = bitcast i8* %_234 to i8**
    %_236 = load i8*, i8** %_235
    ret i8* %_236
}

define i1 @List.Print(i8* %this) {
    %aux01 = alloca i8*

    %var_end = alloca i1

    %var_elem = alloca i8*

    store i8* %this, i8** %aux01

    %_237 = getelementptr i8, i8* %this, i32 24
    %_238 = bitcast i8* %_237 to i1*
    %_239 = load i1, i1* %_238
    store i1 %_239, i1* %var_end

    %_240 = getelementptr i8, i8* %this, i32 8
    %_241 = bitcast i8* %_240 to i8**
    %_242 = load i8*, i8** %_241
    store i8* %_242, i8** %var_elem

    br label %Label43
Label43:
    %_244 = load i1, i1* %var_end
    %_243 = add i1 %_244, 1
    br i1 %_243, label %Label44, label %Label45
Label44:
    %_245 = load i8*, i8** %var_elem
    %_246 = bitcast i8* %_245 to i8***
    %_247 = load i8**, i8*** %_246
    %_248 = getelementptr i8*, i8** %_247, i32 1
    %_249 = load i8*, i8** %_248
    %_250 = bitcast i8* %_249 to i32 (i8*)*
    %_251 = call i32 %_250(i8* %_245)
    call void @print_int(i32 %_251)
    %_252 = load i8*, i8** %aux01
    %_253 = bitcast i8* %_252 to i8***
    %_254 = load i8**, i8*** %_253
    %_255 = getelementptr i8*, i8** %_254, i32 8
    %_256 = load i8*, i8** %_255
    %_257 = bitcast i8* %_256 to i8* (i8*)*
    %_258 = call i8* %_257(i8* %_252)
    store i8* %_258, i8** %aux01

    %_259 = load i8*, i8** %aux01
    %_260 = bitcast i8* %_259 to i8***
    %_261 = load i8**, i8*** %_260
    %_262 = getelementptr i8*, i8** %_261, i32 6
    %_263 = load i8*, i8** %_262
    %_264 = bitcast i8* %_263 to i1 (i8*)*
    %_265 = call i1 %_264(i8* %_259)
    store i1 %_265, i1* %var_end

    %_266 = load i8*, i8** %aux01
    %_267 = bitcast i8* %_266 to i8***
    %_268 = load i8**, i8*** %_267
    %_269 = getelementptr i8*, i8** %_268, i32 7
    %_270 = load i8*, i8** %_269
    %_271 = bitcast i8* %_270 to i8* (i8*)*
    %_272 = call i8* %_271(i8* %_266)
    store i8* %_272, i8** %var_elem

    br label %Label43
Label45:

    ret i1 1
}

define i32 @LL.Start(i8* %this) {
    %head = alloca i8*

    %last_elem = alloca i8*

    %aux01 = alloca i1

    %el01 = alloca i8*

    %el02 = alloca i8*

    %el03 = alloca i8*

    %_273 = call i8* @calloc(i32 1, i32 25)
    %_274 = bitcast i8* %_273 to i8***
    %_275 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    store i8** %_275, i8*** %_274
    store i8* %_273, i8** %last_elem

    %_276 = load i8*, i8** %last_elem
    %_277 = bitcast i8* %_276 to i8***
    %_278 = load i8**, i8*** %_277
    %_279 = getelementptr i8*, i8** %_278, i32 0
    %_280 = load i8*, i8** %_279
    %_281 = bitcast i8* %_280 to i1 (i8*)*
    %_282 = call i1 %_281(i8* %_276)
    store i1 %_282, i1* %aux01

    %_283 = load i8*, i8** %last_elem
    store i8* %_283, i8** %head

    %_284 = load i8*, i8** %head
    %_285 = bitcast i8* %_284 to i8***
    %_286 = load i8**, i8*** %_285
    %_287 = getelementptr i8*, i8** %_286, i32 0
    %_288 = load i8*, i8** %_287
    %_289 = bitcast i8* %_288 to i1 (i8*)*
    %_290 = call i1 %_289(i8* %_284)
    store i1 %_290, i1* %aux01

    %_291 = load i8*, i8** %head
    %_292 = bitcast i8* %_291 to i8***
    %_293 = load i8**, i8*** %_292
    %_294 = getelementptr i8*, i8** %_293, i32 9
    %_295 = load i8*, i8** %_294
    %_296 = bitcast i8* %_295 to i1 (i8*)*
    %_297 = call i1 %_296(i8* %_291)
    store i1 %_297, i1* %aux01

    %_298 = call i8* @calloc(i32 1, i32 17)
    %_299 = bitcast i8* %_298 to i8***
    %_300 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    store i8** %_300, i8*** %_299
    store i8* %_298, i8** %el01

    %_301 = load i8*, i8** %el01
    %_302 = bitcast i8* %_301 to i8***
    %_303 = load i8**, i8*** %_302
    %_304 = getelementptr i8*, i8** %_303, i32 0
    %_305 = load i8*, i8** %_304
    %_306 = bitcast i8* %_305 to i1 (i8*, i32, i32, i1)*
    %_307 = call i1 %_306(i8* %_301, i32 25, i32 37000, i1 0)
    store i1 %_307, i1* %aux01

    %_308 = load i8*, i8** %head
    %_309 = bitcast i8* %_308 to i8***
    %_310 = load i8**, i8*** %_309
    %_311 = getelementptr i8*, i8** %_310, i32 2
    %_312 = load i8*, i8** %_311
    %_313 = bitcast i8* %_312 to i8* (i8*, i8*)*
    %_314 = load i8*, i8** %el01
    %_315 = call i8* %_313(i8* %_308, i8* %_314)
    store i8* %_315, i8** %head

    %_316 = load i8*, i8** %head
    %_317 = bitcast i8* %_316 to i8***
    %_318 = load i8**, i8*** %_317
    %_319 = getelementptr i8*, i8** %_318, i32 9
    %_320 = load i8*, i8** %_319
    %_321 = bitcast i8* %_320 to i1 (i8*)*
    %_322 = call i1 %_321(i8* %_316)
    store i1 %_322, i1* %aux01

    call void @print_int(i32 10000000)
    %_323 = call i8* @calloc(i32 1, i32 17)
    %_324 = bitcast i8* %_323 to i8***
    %_325 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    store i8** %_325, i8*** %_324
    store i8* %_323, i8** %el01

    %_326 = load i8*, i8** %el01
    %_327 = bitcast i8* %_326 to i8***
    %_328 = load i8**, i8*** %_327
    %_329 = getelementptr i8*, i8** %_328, i32 0
    %_330 = load i8*, i8** %_329
    %_331 = bitcast i8* %_330 to i1 (i8*, i32, i32, i1)*
    %_332 = call i1 %_331(i8* %_326, i32 39, i32 42000, i1 1)
    store i1 %_332, i1* %aux01

    %_333 = load i8*, i8** %el01
    store i8* %_333, i8** %el02

    %_334 = load i8*, i8** %head
    %_335 = bitcast i8* %_334 to i8***
    %_336 = load i8**, i8*** %_335
    %_337 = getelementptr i8*, i8** %_336, i32 2
    %_338 = load i8*, i8** %_337
    %_339 = bitcast i8* %_338 to i8* (i8*, i8*)*
    %_340 = load i8*, i8** %el01
    %_341 = call i8* %_339(i8* %_334, i8* %_340)
    store i8* %_341, i8** %head

    %_342 = load i8*, i8** %head
    %_343 = bitcast i8* %_342 to i8***
    %_344 = load i8**, i8*** %_343
    %_345 = getelementptr i8*, i8** %_344, i32 9
    %_346 = load i8*, i8** %_345
    %_347 = bitcast i8* %_346 to i1 (i8*)*
    %_348 = call i1 %_347(i8* %_342)
    store i1 %_348, i1* %aux01

    call void @print_int(i32 10000000)
    %_349 = call i8* @calloc(i32 1, i32 17)
    %_350 = bitcast i8* %_349 to i8***
    %_351 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    store i8** %_351, i8*** %_350
    store i8* %_349, i8** %el01

    %_352 = load i8*, i8** %el01
    %_353 = bitcast i8* %_352 to i8***
    %_354 = load i8**, i8*** %_353
    %_355 = getelementptr i8*, i8** %_354, i32 0
    %_356 = load i8*, i8** %_355
    %_357 = bitcast i8* %_356 to i1 (i8*, i32, i32, i1)*
    %_358 = call i1 %_357(i8* %_352, i32 22, i32 34000, i1 0)
    store i1 %_358, i1* %aux01

    %_359 = load i8*, i8** %head
    %_360 = bitcast i8* %_359 to i8***
    %_361 = load i8**, i8*** %_360
    %_362 = getelementptr i8*, i8** %_361, i32 2
    %_363 = load i8*, i8** %_362
    %_364 = bitcast i8* %_363 to i8* (i8*, i8*)*
    %_365 = load i8*, i8** %el01
    %_366 = call i8* %_364(i8* %_359, i8* %_365)
    store i8* %_366, i8** %head

    %_367 = load i8*, i8** %head
    %_368 = bitcast i8* %_367 to i8***
    %_369 = load i8**, i8*** %_368
    %_370 = getelementptr i8*, i8** %_369, i32 9
    %_371 = load i8*, i8** %_370
    %_372 = bitcast i8* %_371 to i1 (i8*)*
    %_373 = call i1 %_372(i8* %_367)
    store i1 %_373, i1* %aux01

    %_374 = call i8* @calloc(i32 1, i32 17)
    %_375 = bitcast i8* %_374 to i8***
    %_376 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    store i8** %_376, i8*** %_375
    store i8* %_374, i8** %el03

    %_377 = load i8*, i8** %el03
    %_378 = bitcast i8* %_377 to i8***
    %_379 = load i8**, i8*** %_378
    %_380 = getelementptr i8*, i8** %_379, i32 0
    %_381 = load i8*, i8** %_380
    %_382 = bitcast i8* %_381 to i1 (i8*, i32, i32, i1)*
    %_383 = call i1 %_382(i8* %_377, i32 27, i32 34000, i1 0)
    store i1 %_383, i1* %aux01

    %_384 = load i8*, i8** %head
    %_385 = bitcast i8* %_384 to i8***
    %_386 = load i8**, i8*** %_385
    %_387 = getelementptr i8*, i8** %_386, i32 5
    %_388 = load i8*, i8** %_387
    %_389 = bitcast i8* %_388 to i32 (i8*, i8*)*
    %_390 = load i8*, i8** %el02
    %_391 = call i32 %_389(i8* %_384, i8* %_390)
    call void @print_int(i32 %_391)
    %_392 = load i8*, i8** %head
    %_393 = bitcast i8* %_392 to i8***
    %_394 = load i8**, i8*** %_393
    %_395 = getelementptr i8*, i8** %_394, i32 5
    %_396 = load i8*, i8** %_395
    %_397 = bitcast i8* %_396 to i32 (i8*, i8*)*
    %_398 = load i8*, i8** %el03
    %_399 = call i32 %_397(i8* %_392, i8* %_398)
    call void @print_int(i32 %_399)
    call void @print_int(i32 10000000)
    %_400 = call i8* @calloc(i32 1, i32 17)
    %_401 = bitcast i8* %_400 to i8***
    %_402 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    store i8** %_402, i8*** %_401
    store i8* %_400, i8** %el01

    %_403 = load i8*, i8** %el01
    %_404 = bitcast i8* %_403 to i8***
    %_405 = load i8**, i8*** %_404
    %_406 = getelementptr i8*, i8** %_405, i32 0
    %_407 = load i8*, i8** %_406
    %_408 = bitcast i8* %_407 to i1 (i8*, i32, i32, i1)*
    %_409 = call i1 %_408(i8* %_403, i32 28, i32 35000, i1 0)
    store i1 %_409, i1* %aux01

    %_410 = load i8*, i8** %head
    %_411 = bitcast i8* %_410 to i8***
    %_412 = load i8**, i8*** %_411
    %_413 = getelementptr i8*, i8** %_412, i32 2
    %_414 = load i8*, i8** %_413
    %_415 = bitcast i8* %_414 to i8* (i8*, i8*)*
    %_416 = load i8*, i8** %el01
    %_417 = call i8* %_415(i8* %_410, i8* %_416)
    store i8* %_417, i8** %head

    %_418 = load i8*, i8** %head
    %_419 = bitcast i8* %_418 to i8***
    %_420 = load i8**, i8*** %_419
    %_421 = getelementptr i8*, i8** %_420, i32 9
    %_422 = load i8*, i8** %_421
    %_423 = bitcast i8* %_422 to i1 (i8*)*
    %_424 = call i1 %_423(i8* %_418)
    store i1 %_424, i1* %aux01

    call void @print_int(i32 2220000)
    %_425 = load i8*, i8** %head
    %_426 = bitcast i8* %_425 to i8***
    %_427 = load i8**, i8*** %_426
    %_428 = getelementptr i8*, i8** %_427, i32 4
    %_429 = load i8*, i8** %_428
    %_430 = bitcast i8* %_429 to i8* (i8*, i8*)*
    %_431 = load i8*, i8** %el02
    %_432 = call i8* %_430(i8* %_425, i8* %_431)
    store i8* %_432, i8** %head

    %_433 = load i8*, i8** %head
    %_434 = bitcast i8* %_433 to i8***
    %_435 = load i8**, i8*** %_434
    %_436 = getelementptr i8*, i8** %_435, i32 9
    %_437 = load i8*, i8** %_436
    %_438 = bitcast i8* %_437 to i1 (i8*)*
    %_439 = call i1 %_438(i8* %_433)
    store i1 %_439, i1* %aux01

    call void @print_int(i32 33300000)
    %_440 = load i8*, i8** %head
    %_441 = bitcast i8* %_440 to i8***
    %_442 = load i8**, i8*** %_441
    %_443 = getelementptr i8*, i8** %_442, i32 4
    %_444 = load i8*, i8** %_443
    %_445 = bitcast i8* %_444 to i8* (i8*, i8*)*
    %_446 = load i8*, i8** %el01
    %_447 = call i8* %_445(i8* %_440, i8* %_446)
    store i8* %_447, i8** %head

    %_448 = load i8*, i8** %head
    %_449 = bitcast i8* %_448 to i8***
    %_450 = load i8**, i8*** %_449
    %_451 = getelementptr i8*, i8** %_450, i32 9
    %_452 = load i8*, i8** %_451
    %_453 = bitcast i8* %_452 to i1 (i8*)*
    %_454 = call i1 %_453(i8* %_448)
    store i1 %_454, i1* %aux01

    call void @print_int(i32 44440000)
    ret i32 0
}
