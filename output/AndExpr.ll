@.AndExpr_vtable = global [0 x i8*] []

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
    %_0 = alloca i1
    br i1 1, label %Label4, label %Label5
Label4:
    br i1 0, label %Label3, label %Label5
Label3:
    store i1 1 , i1* %_0
    br label %Label6
Label5:
    store i1 0 , i1* %_0
    br label %Label6
Label6:
    %_1 = load i1, i1* %_0
    br i1 %_1, label %Label0, label %Label1
Label0:
    call void @print_int(i32 1)
    br label %Label2
Label1:
    call void @print_int(i32 0)
    br label %Label2
Label2:

    ret i32 0
}
