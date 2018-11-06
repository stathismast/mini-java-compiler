import syntaxtree.*;
import visitor.GJDepthFirst;
import java.util.*;


import java.io.BufferedWriter;
import java.io.IOException;

class LLVMVisitor extends GJDepthFirst<String, String> {
    private final BufferedWriter writer;

    //curVar and curLabel are used to produce a new name for variables and labels
    private int curVar;
    private int curLabel;

    //Loading classTable from GatherVisitor, offsetTable from OffsetVisitor
    private HashMap<String, ClassInfo> classTable = GatherVisitor.classTable;
    private HashMap<String, OffsetInfo> offsetTable = OffsetVisitor.offsetTable;

    //List of Strings containing the type of every Object for which a function is called
    private ArrayList<String> typeOfObject = TypeCheckVisitor.typeOfObject;

    //Map linking a method name with its specification (return type and argument types)
    //The specifications of each class are stored in Strings.
    public static HashMap<String, String> methodSpecs = new HashMap<String, String>();

    //List of strings containing information about the return type and argument
    //types for every functions that is called
    public static ArrayList<String> expressionList = new ArrayList<String>();

    //Used my getVariableOffset
    //getVariableOffset finds the offset of a variable and stores its type
    //in this variable, in case its useful information for whoever called getVariableOffset
    private String tempType;

    String currentClass;
    String currentMethod;

    //String used to produce vtable
    String vtable;

    //String that is initialized in MethodDeclaration and used
    //to produce the parameteres for each of the declared methods
    String params;

    public void init(){
        methodSpecs.clear();
        expressionList.clear();
    }

    public LLVMVisitor(BufferedWriter bw){
        this.writer = bw;
    }

    private String nextVar(){
        this.curVar++;
        return "%_" + (curVar-1);
    }

    private String nextLabel(){
        this.curLabel++;
        return "Label" + (curLabel-1);
    }

    private void emit(String s){
        try{
            writer.write(s);
            writer.newLine();
        }
        catch (IOException e){
            System.out.println(e.toString());
        }
    }

    //Convert a String with the type in Java
    //to each equivalent in LLVM IR
    public String getType(String type){
        if(type.equals("int")){
            type = "i32";
        }
        else if(type.equals("int[]")){
            type = "i32*";
        }
        else if(type.equals("boolean")){
            type = "i1";
        }
        else{
            type = "i8*";  //must be an object of a declared class
        }
        return type;
    }

    //Find and return the offset of a given method for a given class
    //If the method is not directly declared in the given class, it will
    //search for it in any parent class it may have
    public int getMethodOffset(String className, String methodName){
        if(!offsetTable.containsKey(className)){
            System.err.println("ERROR: Function called for invalid class."); //should be detected from TypeCheckVisitor
            return -1;
        }
        boolean done = false;
        int offset = 0;
        while(!done){
            if(!offsetTable.get(className).methods.contains(methodName)){
                if(!offsetTable.containsKey(offsetTable.get(className).classExtends)){
                    System.err.println("ERROR: Function called for invalid class. doesnt have parent"); //should be detected from TypeCheckVisitor
                    System.err.println("method " + methodName + " class " + className);
                    return -1;
                }
                //Look for it in the parent of this class
                className =  offsetTable.get(className).classExtends;
            }
            else{
                int index = offsetTable.get(className).methods.indexOf(methodName);
                offset = offsetTable.get(className).methodOffsets.get(index);
                done = true;
            }
        }
        return offset;
    }

    //Similar to getMethodOffset but for class variables
    public int getVariableOffset(String className, String varName){
        if(!offsetTable.containsKey(className)){
            System.err.println("ERROR: Variable " + varName + " does not exist."); //should be detected from TypeCheckVisitor
            return -1;
        }
        boolean done = false;
        int offset = 0;
        while(!done){
            if(!offsetTable.get(className).variables.contains(varName)){
                if(!offsetTable.containsKey(offsetTable.get(className).classExtends)){
                    System.err.println("ERROR: Variable " + varName + " does not exist."); //should be detected from TypeCheckVisitor
                    System.err.println("variable " + varName + " class " + className);
                    return -1;
                }
                //Look for it in the parent of this class
                className =  offsetTable.get(className).classExtends;
            }
            else{
                int index = offsetTable.get(className).variables.indexOf(varName);
                offset = offsetTable.get(className).variableOffsets.get(index);
                tempType = classTable.get(className).variables.get(varName);
                tempType = getType(tempType);
                done = true;
            }
        }
        return offset;
    }

    //Emit vtable for given className
    public void emitVtable(String className){
        //If its the class with the main method
        if(className == currentClass) return;

        //if this class has no methods (of its own or any inherited)
        if(offsetTable.get(className).metOffset == 0){
            emit("@." + className + "_vtable = global [0 x i8*] []");
            return;
        }

        String tempName = className;  //keep the name of the original class that 'emitVtable' was called for

        //If this class has no methods of its own, but inherits methods from its parent.
        //Its vtable is going to be the same as its parent's so we change the name to that of its parent
        //That way all the methods are going to have the same name as in the parent
        //but the global variable (vtable) will have the name of the original class (tempName)
        if(classTable.get(className).methods.size() == 0)
            className = classTable.get(className).classExtends;

        int methodNum = offsetTable.get(className).metOffset/8;
        int nextOffset = 0;
        int methodCount = 0;

        vtable = "[";
        for(String methodName : classTable.get(className).methods.keySet()){
            while(getMethodOffset(className, methodName) > nextOffset) //if there are any inherited methods
                nextOffset = addNextInheritedMethod(className, nextOffset, tempName);
            methodCount = nextOffset/8;

            //If this method is overriding an inherited method that has already
            //been added to the vtable String, we have to go and replace the name of that method
            if(getMethodOffset(className, methodName) < nextOffset){
                String parent =  classTable.get(className).classExtends;
                OffsetInfo tempOffsetInfo;
                while(true){
                    if(parent == null) System.out.println("Error in 'emitVtable'. " + vtable); //will not happen for a valid input

                    if(classTable.get(parent).methods.containsKey(methodName)){
                        int start = vtable.indexOf(parent + "." + methodName);
                        int end = start + parent.length();

                        //change parent's name with the derived class' name
                        String left = vtable.substring(0, start);
                        String right = vtable.substring(end, vtable.length());
                        vtable = left + className + right;
                        break;
                    }
                }
                continue;
            }

            addNextMethod(className, tempName, methodName);

            nextOffset+=8;
            methodCount++;
        }

        while(nextOffset < methodNum*8)
            nextOffset = addNextInheritedMethod(className, nextOffset, tempName);
        methodCount = nextOffset/8;

        if(vtable.lastIndexOf(",") == vtable.length()-2 && vtable.lastIndexOf(",") != -1) vtable = vtable.substring(0, vtable.lastIndexOf(","));
        vtable = "@." + tempName + "_vtable = global [" + methodCount + " x i8*] " + vtable + "]";
        emit(vtable);
    }

    //Add an inherited method to the vtable String according to value of given 'nextOffset'
    public int addNextInheritedMethod(String className, int nextOffset, String tempName){
        String parent =  classTable.get(className).classExtends;
        OffsetInfo tempOffsetInfo;
        while(true){
            if(parent == null) System.out.println("Error in 'emitInheritedMethods'. " + vtable); //will not happen for a valid input

            tempOffsetInfo = offsetTable.get(parent);
            if(tempOffsetInfo.methodOffsets.contains(nextOffset)){
                String inheritedMethodName = tempOffsetInfo.methods.get(tempOffsetInfo.methodOffsets.indexOf(nextOffset));
                addNextMethod(parent, tempName, inheritedMethodName);
                nextOffset+=8;
                break;
            }
            else{
                //If 'parent' doesnt have the method we are looking for
                //look for it in next parent
                parent = classTable.get(parent).classExtends;
            }
        }
        return nextOffset;
    }

    //Add a method to the vtable string and update methodSpecs
    public void addNextMethod(String className, String tempName, String methodName){
        MethodInfo tempMethodInfo;
        String methodSpecification;

        tempMethodInfo = classTable.get(className).methods.get(methodName);
        vtable += "i8* bitcast (" + getType(tempMethodInfo.type) + " (i8*, ";
        methodSpecification = getType(tempMethodInfo.type) + " (i8*, ";
        for(int i=0; i<tempMethodInfo.parameters.size(); i++){
            vtable += getType(tempMethodInfo.parameters.get(i)) + ", ";
            methodSpecification += getType(tempMethodInfo.parameters.get(i)) + ", ";
        }
        if(vtable.lastIndexOf(",") == vtable.length()-2) vtable = vtable.substring(0, vtable.lastIndexOf(","));
        if(methodSpecification.lastIndexOf(",") == methodSpecification.length()-2) methodSpecification = methodSpecification.substring(0, methodSpecification.lastIndexOf(","));
        vtable += ")* @" + className + "." + methodName + " to i8*), ";
        methodSpecification += ")*";
        methodSpecs.put(tempName + "." + methodName, methodSpecification);
    }

    public String visit(MainClass n, String argu) throws Exception {
        currentClass = n.f1.f0.toString();
        currentMethod = "main";

        emit("@." + currentClass + "_vtable = global [0 x i8*] []");


        for(String className : classTable.keySet()){
            emitVtable(className);
        }

        emit("");

        emit( "declare i8* @calloc(i32, i32)\n" +
              "declare i32 @printf(i8*, ...)\n" +
              "declare void @exit(i32)\n" +
              "\n" +
              "@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n" +
              "@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n" +
              "\n" +
              "define void @print_int(i32 %i) {\n" +
              "    %_str = bitcast [4 x i8]* @_cint to i8*\n" +
              "    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n" +
              "    ret void\n" +
              "}\n" +
              "\n" +
              "define void @throw_oob() {\n" +
              "    %_str = bitcast [15 x i8]* @_cOOB to i8*\n" +
              "    call i32 (i8*, ...) @printf(i8* %_str)\n" +
              "    call void @exit(i32 1)\n" +
              "    ret void\n" +
              "}\n"
              );

        emit("define i32 @main() {");

        n.f14.accept(this, argu);
        n.f15.accept(this, argu);

        emit("    ret i32 0");
        emit("}");

        currentClass = null;
        currentMethod = null;
        return null;
    }

    public String visit(ClassDeclaration n, String argu) throws Exception {
        currentClass = n.f1.f0.toString();
        n.f3.accept(this, "classVariable");
        n.f4.accept(this, argu);
        currentClass = null;
        return null;
    }

    public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
        currentClass = n.f1.f0.toString();
        n.f5.accept(this, "classVariable");
        n.f6.accept(this, argu);
        currentClass = null;
        return null;
    }

    public String visit(MethodDeclaration n, String argu) throws Exception {
        String methodType = n.f1.accept(this, argu);
        currentMethod = n.f2.f0.toString();

        //String params is initialized and the node FormalParameterList is visited.
        //In FormalParameterList, every parameter will be added in 'params'
        params = "i8* %this,";
        n.f4.accept(this, argu);
        params = params.substring(0, params.length() - 1); //Delete the ',' at the end of 'params'

        emit("");
        emit("define " + methodType + " @" + currentClass + "." + currentMethod + "(" + params + ") {");

        //If this method has a parameter other than '%this'
        //We need to allocate space for every one of those parameters
        if(params.length() > 10){
            params = params.substring(11, params.length());
            ArrayList<String> arguments = new ArrayList<String>();
            ArrayList<String> argTypes =  new ArrayList<String>();
            ArrayList<String> argNames =  new ArrayList<String>();
            boolean done = false;
            while(!done){
                if(params.indexOf(",") > 0){
                    arguments.add(params.substring(0, params.indexOf(",")));
                    params = params.substring(params.indexOf(",")+2, params.length());
                }
                else{
                    arguments.add(params);
                    done = true;
                }
            }
            for(int i=0; i<arguments.size(); i++){
                argTypes.add(arguments.get(i).substring(0, arguments.get(i).indexOf(" ")));
                argNames.add(arguments.get(i).substring(arguments.get(i).indexOf(" ")+3, arguments.get(i).length()));

                emit("    %" + argNames.get(i) + " = alloca " + argTypes.get(i));
                emit("    store " + argTypes.get(i) + " %." + argNames.get(i) + ", " + argTypes.get(i) + "* %" + argNames.get(i));
                emit("");
            }

        }

        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        emit("    ret " + methodType + " " + n.f10.accept(this, "load"));
        emit("}");
        currentMethod = null;
        return null;
    }

    public String visit(IntegerLiteral n, String argu) throws Exception {
        return n.f0.toString();
    }

    public String visit(PlusExpression n, String argu) throws Exception {
        String nextVar = nextVar();
        emit("    " + nextVar + " = add i32 " + n.f0.accept(this, "load") + ", " + n.f2.accept(this, "load"));
        return nextVar;
    }

    public String visit(MinusExpression n, String argu) throws Exception {
       String nextVar = nextVar();
       emit("    " + nextVar + " = sub i32 " + n.f0.accept(this, "load") + ", " + n.f2.accept(this, "load"));
       return nextVar;
    }

    public String visit(TimesExpression n, String argu) throws Exception {
      String nextVar = nextVar();
      emit("    " + nextVar + " = mul i32 " + n.f0.accept(this, "load") + ", " + n.f2.accept(this, "load"));
      return nextVar;
    }

    public String visit(CompareExpression n, String argu) throws Exception {
      String nextVar = nextVar();
      emit("    " + nextVar + " = icmp slt i32 " + n.f0.accept(this, "load") + ", " + n.f2.accept(this, "load"));
      return nextVar;
    }

    public String visit(PrintStatement n, String argu) throws Exception {
       emit("    call void @print_int(i32 " + n.f2.accept(this, "load") + ")");
       return null;
    }

    public String visit(TrueLiteral n, String argu) throws Exception {
        return "1";
    }

    public String visit(FalseLiteral n, String argu) throws Exception {
        return "0";
    }


    public String visit(IfStatement n, String argu) throws Exception {
       String trueLabel = nextLabel();
       String falseLabel = nextLabel();
       String contLabel = nextLabel();
       String condition = n.f2.accept(this, "load");
       emit("    br i1 " + condition + ", label %" + trueLabel + ", label %" + falseLabel);
       emit(trueLabel + ":");
       n.f4.accept(this, argu);
       emit("    " + "br label %" + contLabel);
       emit(falseLabel + ":");
       n.f6.accept(this, argu);
       emit("    " + "br label %" + contLabel);
       emit(contLabel + ":");
       emit("");
       return null;
    }

    public String visit(WhileStatement n, String argu) throws Exception {
       String conditionLabel = nextLabel();
       String continueLabel = nextLabel();
       String breakLabel = nextLabel();
       emit("    br label %" + conditionLabel);
       emit(conditionLabel + ":");
       String condition = n.f2.accept(this, "load");
       emit("    br i1 " + condition + ", label %" + continueLabel + ", label %" + breakLabel);
       emit(continueLabel + ":");
       n.f4.accept(this, argu);
       emit("    " + "br label %" + conditionLabel);
       emit(breakLabel + ":");
       emit("");
       return null;
    }

    public String visit(BracketExpression n, String argu) throws Exception {
       return n.f1.accept(this, argu);
   }

    public String visit(Type n, String argu) throws Exception {
        String type = n.f0.accept(this, argu);

        //If it is an object (not int, int[] or boolean)
        if(type.contains("%")){
            type = "i8*";
        }
        return type;
    }

    public String visit(ArrayType n, String argu) throws Exception {
       return "i32*";
    }

    public String visit(BooleanType n, String argu) throws Exception {
       return "i1";
    }

    public String visit(IntegerType n, String argu) throws Exception {
       return "i32";
    }


    public String visit(Identifier n, String argu) throws Exception {
        //If this node is visted with "load" as an argument, that means that is a
        //variable of some sort that we want to have its value loaded
        //If it is not visited with "load" as its argument, we just return its name
        if(argu != null && argu.equals("load")){
            if(TypeCheckVisitor.isMethodVariable(currentClass, currentMethod, n.f0.toString())){
                String type = TypeCheckVisitor.getType(currentClass, currentMethod, n.f0.toString());
                type = getType(type);
                String nextVar = nextVar();
                emit("    " + nextVar + " = load " + type + ", " + type + "* %" + n.f0.toString());
                return nextVar;
            }
            else{ //must be a class field/variable
                int offset = getVariableOffset(currentClass, n.f0.toString());
                offset += 8;
                String var0 = nextVar();
                emit("    " + var0 + " = getelementptr i8, i8* %this, i32 " + offset);
                String var1 = nextVar();
                emit("    " + var1 + " = bitcast i8* " + var0 + " to " + tempType + "*");
                String var2 = nextVar();
                emit("    " + var2 + " = load " + tempType + ", " + tempType + "* " + var1);
                return var2;
            }
        }
       return "%" + n.f0.toString();
    }

    public String visit(VarDeclaration n, String argu) throws Exception {
        if(argu != null && argu.equals("classVariable")) return null; //no need to emit anything if it is a class field

        String type = n.f0.accept(this, argu);
        emit("    %" + n.f1.f0.toString() + " = alloca " + type);
        emit("");
        return null;
    }

    public String visit(AssignmentStatement n, String argu) throws Exception {
        String type = TypeCheckVisitor.getType(currentClass, currentMethod, n.f0.f0.toString());
        type = getType(type);

        if(TypeCheckVisitor.isMethodVariable(currentClass, currentMethod, n.f0.f0.toString())){
            emit("    store " + type + " " + n.f2.accept(this, "load") + ", " + type + "* " + "%" + n.f0.f0.toString());
        }
        else{ //must be a class field/variable
            int offset = getVariableOffset(currentClass, n.f0.f0.toString());
            offset += 8;
            String var0 = nextVar();
            emit("    " + var0 + " = getelementptr i8, i8* %this, i32 " + offset);
            String var1 = nextVar();
            emit("    " + var1 + " = bitcast i8* " + var0 + " to " + type + "*");
            emit("    store " + type + " " + n.f2.accept(this, "load") + ", " + type + "* " + var1);
            return var1;
        }
        emit("");
        return null;
    }


    public String visit(ArrayAllocationExpression n, String argu) throws Exception {
        String size = n.f3.accept(this, "load");
        String var0 = nextVar();
        emit("    " + var0 + " = add i32 " + size + ", 1");
        String var1 = nextVar();
        emit("    " + var1 + " = call i8* @calloc(i32 4, i32 " + var0 + ")");
        String var2 = nextVar();
        emit("    " + var2 + " = bitcast i8* " + var1 + " to i32*");
        emit("    store i32 " + size + ", i32* " + var2);
        return var2;
    }


    public String visit(ArrayLookup n, String argu) throws Exception {
       String array = n.f0.accept(this, "load");
       String index = n.f2.accept(this, "load");

       String oobCheck = nextLabel(); //Out of Bounds Check
       String iobLabel = nextLabel(); //Inside of Bounds Label (to jump to if the index is valid)
       String oobLabel = nextLabel(); //Outside of Bounds Label (to jump to if the index is invalid)
       String continueLabel = nextLabel();

       //Check if index is less than 0
       String var0 = nextVar();
       emit("    " + var0 + " = icmp slt i32 " + index + ", 0");
       emit("    br i1 " + var0 + ", label %" + oobLabel + ", label %" + oobCheck);
       emit("");

       //Check if index is out of bounds
       emit(oobCheck + ":");
       String var1 = nextVar();
       emit("    " + var1 + " = getelementptr i32, i32* " + array + ", i32 0");
       String length = nextVar();
       emit("    " + length + " = load i32, i32* " + var1);
       String condition = nextVar();
       emit("    " + condition + " = icmp slt i32 " + index + ", " + length);
       emit("    br i1 " + condition + ", label %" + iobLabel + ", label %" + oobLabel);
       emit("");


       emit(iobLabel + ":");
       String var3 = nextVar();
       emit("    " + var3 + " = add i32 " + index + ", 1");
       String var4 = nextVar();
       emit("    " + var4 + " = getelementptr i32, i32* " + array + ", i32 " + var3);
       String var5 = nextVar();
       emit("    " + var5 + " = load i32, i32* " + var4);
       emit("    br label %" + continueLabel);
       emit("");

       emit(oobLabel + ":");
       emit("    call void @throw_oob()");
   	   emit("    br label %" + continueLabel);
       emit("");

       emit(continueLabel + ":");

       return var5;
    }

    public String visit(ArrayLength n, String argu) throws Exception {
       String array = n.f0.accept(this, "load");

       String var0 = nextVar();
       emit("    " + var0 + " = getelementptr i32, i32* " + array + ", i32 0");
       String var1 = nextVar();
       emit("    " + var1 + " = load i32, i32* " + var0);
       return var1;
    }

    public String visit(ArrayAssignmentStatement n, String argu) throws Exception {
       String array = n.f0.accept(this, "load");
       String index = n.f2.accept(this, "load");
       String value = n.f5.accept(this, "load");

       String oobCheck = nextLabel();
       String iobLabel = nextLabel();
       String oobLabel = nextLabel();
       String continueLabel = nextLabel();

       //check if index is less than 0
       String var0 = nextVar();
       emit("    " + var0 + " = icmp slt i32 " + index + ", 0");
       emit("    br i1 " + var0 + ", label %" + oobLabel + ", label %" + oobCheck);
       emit("");

       //check if index is out of bounds
       emit(oobCheck + ":");
       String var1 = nextVar();
       emit("    " + var1 + " = getelementptr i32, i32* " + array + ", i32 0");
       String length = nextVar();
       emit("    " + length + " = load i32, i32* " + var1);
       String condition = nextVar();
       emit("    " + condition + " = icmp slt i32 " + index + ", " + length);
       emit("    br i1 " + condition + ", label %" + iobLabel + ", label %" + oobLabel);
       emit("");


       emit(iobLabel + ":");
       String var2 = nextVar();
       emit("    " + var2 + " = add i32 " + index + ", 1");
       String var3 = nextVar();
       emit("    " + var3 + " = getelementptr i32, i32* " + array + ", i32 " + var2);
       String var4 = nextVar();
       emit("    store i32 " + value + ", i32* " + var3);
       emit("    br label %" + continueLabel);
       emit("");

       emit(oobLabel + ":");
       emit("    call void @throw_oob()");
  	   emit("    br label %" + continueLabel);
       emit("");

       emit(continueLabel + ":");

       return null;
    }


    //This node does not use phi, but short circuiting is still achieved.
    //Say we have something like: a && b
    //Firstly we allocate a boolean variable (bool) and we check
    //condition 'a'. If 'a' is true we check 'b' as well, BUT if 'a' is false
    //we jump to 'falseLabel' which gives 'bool' a false value without having
    //to check if 'b' is true or not.
    //If 'a' is true and 'b' true we jump to the 'trueLabel'
    //which gives 'bool' a 'true' value. But if 'a' is true and 'b'
    //is false, we again jump to 'falseLabel'.
    public String visit(AndExpression n, String argu) throws Exception {
        String trueLabel = nextLabel();
        String secondCheck = nextLabel();
        String falseLabel = nextLabel();
        String continueLabel = nextLabel();

        String bool = nextVar();
        emit("    " + bool + " = alloca i1");
        emit("    br i1 " + n.f0.accept(this, "load") + ", label %" + secondCheck + ", label %" + falseLabel);
        emit(secondCheck + ":");
        emit("    br i1 " + n.f2.accept(this, "load") + ", label %" + trueLabel + ", label %" + falseLabel);
        emit(trueLabel + ":");
        emit("    store i1 1 , i1* " + bool);
        emit("    br label %" + continueLabel);
        emit(falseLabel + ":");
        emit("    store i1 0 , i1* " + bool);
        emit("    br label %" + continueLabel);

        emit(continueLabel + ":");
        String result = nextVar();
        emit("    " + result + " = load i1, i1* " + bool);
        return result;
    }

    public String visit(NotExpression n, String argu) throws Exception {
       String nextVar = nextVar();
       emit("    " + nextVar + " = add i1 " + n.f1.accept(this, argu) + ", 1");
       return nextVar;
    }

    public String visit(AllocationExpression n, String argu) throws Exception {
        String className = n.f1.f0.toString();
        int methodNum;
        int objectSize;

        //If and only if the class contains the main method
        if(!offsetTable.containsKey(className)){
            methodNum = 0;
            objectSize = 0;
        }
        else{
            methodNum = offsetTable.get(className).metOffset/8;
            objectSize = offsetTable.get(className).varOffset;
        }
        objectSize += 8;
        String var0 = nextVar();
        emit("    " + var0 + " = call i8* @calloc(i32 1, i32 " + objectSize + ")");
        String var1 = nextVar();
        emit("    " + var1 +" = bitcast i8* " + var0 + " to i8***");
        String var2 = nextVar();
        emit("    " + var2 + " = getelementptr [" + methodNum + " x i8*], [" + methodNum + " x i8*]* @." + className + "_vtable, i32 0, i32 0");
        emit("    store i8** " + var2 + ", i8*** " + var1);
        return var0;
    }

    public String visit(FormalParameterList n, String argu) throws Exception {
       n.f0.accept(this, argu);
       n.f1.accept(this, argu);
       return null;
    }

    //This node adds to the 'params' String to be used by MethodDeclaration
    public String visit(FormalParameter n, String argu) throws Exception {
        String type = n.f0.accept(this, argu);
        String name = n.f1.accept(this, argu);
        name = name.substring(1, name.length());
        params += " " + type + " %." + name + ",";
        return null;
    }

    public String visit(FormalParameterTail n, String argu) throws Exception {
       return n.f0.accept(this, argu);
    }

    public String visit(FormalParameterTerm n, String argu) throws Exception {
       n.f1.accept(this, argu);
       return null;
    }

    //This method uses a lot of the prepared data structures (typeOfObject, methodSpecs)
    //To collect all the information it needs to properly call the given method
    //Information such as the return type of said method, the type of each argument,
    //the offset of this method in its class, the type of the object that this method
    //is called for.
    public String visit(MessageSend n, String argu) throws Exception {
       String object = n.f0.accept(this, "load");
       String methodName = n.f2.accept(this, null);
       methodName = methodName.substring(1, methodName.length());

       String var0 = nextVar();
       emit("    " + var0 + " = bitcast i8* " + object + " to i8***");
       String var1 = nextVar();
       emit("    " + var1 + " = load i8**, i8*** " + var0);

       String className = typeOfObject.get(0);
       typeOfObject.remove(0);

       int offset = getMethodOffset(className, methodName);

       String var3 = nextVar();
       emit("    " + var3 + " = getelementptr i8*, i8** " + var1 + ", i32 " + offset/8);
       String var4 = nextVar();
       emit("    " + var4 + " = load i8*, i8** " + var3);
       String var5 = nextVar();
       String specs = methodSpecs.get(className + "." + methodName);
       emit("    " + var5 + " = bitcast i8* " + var4 + " to " + specs);

       n.f4.accept(this, "exprList");

       String methodType = specs.substring(0, specs.indexOf(" "));
       ArrayList<String> argTypes = new ArrayList<String>();
       if(specs.indexOf(",") > 0){
           specs = specs.substring(specs.indexOf(",")+2, specs.length()-2);
           while(specs.indexOf(",") > 0){
               argTypes.add(specs.substring(0, specs.indexOf(",")));
               specs = specs.substring(specs.indexOf(",")+2, specs.length());
           }
           argTypes.add(specs);
       }

       //'arguments' String will recieve every argument that needs to be used to call this method
       //The following 'for loop' is set up in such a way that it can produce correct code in case we have
       //something like: foo(boo(x,y), bar(z,w))
       //Whenever the code for method bar is generated the 'expressionList' structure
       //will hold information for method foo, so we only need to extract the information we need for bar
       //I hope this makes some sense, but I understand if it doesnt. It's not the optimal way to do this, but it worked for me (maybe a stack would be better)
       String arguments = "";
       int j = 0;
       for(int i=expressionList.size() - argTypes.size(); i<expressionList.size(); i++){
           arguments += ", " + argTypes.get(j) + " " + expressionList.get(i);
           j++;
       }

       String var6 = nextVar();
       emit("    " + var6 + " = call " + methodType + " " + var5 + "(i8* " + object + arguments + ")");

       expressionList.subList(expressionList.size()-argTypes.size(), expressionList.size()).clear();

       return var6;
    }


    public String visit(Expression n, String argu) throws Exception {
        //If this node is visited from 'messageSent' we want to load each expression
        //to be used as argument for the method call
        if(argu != null && argu.equals("exprList")){
            expressionList.add(n.f0.accept(this, "load"));
            return null;
        }
       return n.f0.accept(this, argu);
    }

    public String visit(ThisExpression n, String argu) throws Exception {
       return "%this";
    }
}
