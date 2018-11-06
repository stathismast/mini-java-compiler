import syntaxtree.*;
import visitor.GJDepthFirst;
import java.util.*;

public class TypeCheckVisitor extends GJDepthFirst<String, String> {

    private static HashMap<String, ClassInfo> classTable = GatherVisitor.classTable;

    private ArrayList<String> tempParamList = new ArrayList<String>();
    private static String tempType;
    private static String tempClass;
    private static MethodInfo tempMethodInfo;

    static String currentClass;
    static String currentMethod;

    public static ArrayList<String> typeOfObject = new ArrayList<String>();

    public void init(){
        tempParamList.clear();
        tempType = null;
        tempClass = null;
        tempMethodInfo = null;
        typeOfObject.clear();
    }

    public static boolean isClass(String className){
        if(className == null) return false;
        return classTable.containsKey(className);
    }

    public static boolean extendsAnotherClass(String className){
        if(isClass(className)){
            return isClass(classTable.get(className).classExtends);
        }
        return false;
    }

    public static boolean isClassVariable(String className, String varName){
        if (isClass(className)){
            if(classTable.get(className).variables.containsKey(varName)){
                tempType = classTable.get(className).variables.get(varName);
                return true;
            }
        }
        return false;
    }

    public static boolean isVariableOfParentClass(String className, String varName){
        if(extendsAnotherClass(className)){
            String classExtends = classTable.get(className).classExtends;
            if(classTable.get(classExtends).variables.containsKey(varName)){
                tempType = classTable.get(classExtends).variables.get(varName);
                tempClass = classExtends;
                return true;
            }
            else return isVariableOfParentClass(classExtends, varName);
        }
        return false;
    }

    public static boolean isClassMethod(String className, String methodName){
        if (isClass(className)){
            if(classTable.get(className).methods.containsKey(methodName)){
                tempMethodInfo = classTable.get(className).methods.get(methodName);
                return true;
            }
        }
        return false;
    }

    public boolean isMethodOfParent(String className, String methodName){
        if(extendsAnotherClass(className)){
            String classExtends = classTable.get(className).classExtends;
            if(classTable.get(classExtends).methods.containsKey(methodName)){
                tempMethodInfo = classTable.get(classExtends).methods.get(methodName);
                tempClass = classExtends;
                return true;
            }
            else return isMethodOfParent(classExtends, methodName);
        }
        return false;
    }

    public static boolean isMethodVariable(String className, String methodName, String varName){
        if(isClassMethod(className, methodName)){
            if(classTable.get(className).methods.get(methodName).variables.containsKey(varName)){
                tempType = classTable.get(className).methods.get(methodName).variables.get(varName);
                return true;
            }
        }
        return false;
    }

    public boolean isVariableOfParentMethod(String className, String methodName, String varName){
        if(extendsAnotherClass(className)){
            String classExtends = classTable.get(className).classExtends;
            if(isClassMethod(classExtends, methodName)){
                if(classTable.get(classExtends).methods.get(methodName).variables.containsKey(varName)){
                    tempType = classTable.get(classExtends).methods.get(methodName).variables.get(varName);
                    tempClass = classExtends;
                    return true;
                }
                return false;
            }
            else return isVariableOfParentMethod(classExtends, methodName, varName);
        }
        return false;
    }

    private boolean isCompatibleType(String left, String right){
        if(left.equals(right))
            return true;
        if(extendsAnotherClass(left))
            return isCompatibleType(classTable.get(left).classExtends, right);

        return false;
    }

    public static String getType(String curClass, String curMethod, String idName){
        String type;
        if(isMethodVariable(curClass, curMethod, idName)) {
            type = tempType;
        }
        else if(isClassVariable(curClass, idName)){
            type = tempType;
        }
        else if(isVariableOfParentClass(curClass, idName)){
            type = tempType;
        }
        else {
            type = "null";
        }
        return type;
    }

    public static String getClassWhereIdWasDeclared(String className, String idName){
        if(isClassVariable(className, idName)){
            return className;
        }
        else if(isVariableOfParentClass(className, idName)){
            return tempClass;
        }
        else return "ERROR";
    }

     /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( VarDeclaration() )*
     * f4 -> ( MethodDeclaration() )*
     * f5 -> "}"
     */
     public String visit(ClassDeclaration n, String argu) throws Exception {
         String name = n.f1.f0.toString();

         currentClass = name;

         String _ret = null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         n.f3.accept(this, argu);
         n.f4.accept(this, argu);
         n.f5.accept(this, argu);

         currentClass = null;

         return _ret;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "extends"
     * f3 -> Identifier()
     * f4 -> "{"
     * f5 -> ( VarDeclaration() )*
     * f6 -> ( MethodDeclaration() )*
     * f7 -> "}"
     */
      public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
          String name = n.f1.f0.toString();
          String classExtends = n.f3.f0.toString();

          if(!classTable.containsKey(classExtends)){
              throw new Exception("ClassExtendsDeclaration: class " + classExtends + " has not been declared.");
          }

          currentClass = name;

          String _ret = null;
          n.f0.accept(this, argu);
          n.f1.accept(this, argu);
          n.f2.accept(this, argu);
          n.f3.accept(this, argu);
          n.f4.accept(this, argu);
          n.f5.accept(this, argu);
          n.f6.accept(this, argu);
          n.f7.accept(this, argu);

          currentClass = null;

          return _ret;
     }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> "public"
     * f4 -> "static"
     * f5 -> "void"
     * f6 -> "main"
     * f7 -> "("
     * f8 -> "String"
     * f9 -> "["
     * f10 -> "]"
     * f11 -> Identifier()
     * f12 -> ")"
     * f13 -> "{"
     * f14 -> ( VarDeclaration() )*
     * f15 -> ( Statement() )*
     * f16 -> "}"
     * f17 -> "}"
     */
    public String visit(MainClass n, String argu) throws Exception {

        String name = n.f1.f0.toString();

        currentClass = name;

        currentMethod = "main";

        String _ret = null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);
        n.f10.accept(this, argu);
        n.f11.accept(this, argu);
        n.f12.accept(this, argu);
        n.f13.accept(this, argu);
        n.f14.accept(this, argu);
        n.f15.accept(this, argu);
        n.f16.accept(this, argu);
        n.f17.accept(this, argu);

        currentMethod = null;
        currentClass = null;

        return _ret;
    }

       /**
        * f0 -> "public"
        * f1 -> Type()
        * f2 -> Identifier()
        * f3 -> "("
        * f4 -> ( FormalParameterList() )?
        * f5 -> ")"
        * f6 -> "{"
        * f7 -> ( VarDeclaration() )*
        * f8 -> ( Statement() )*
        * f9 -> "return"
        * f10 -> Expression()
        * f11 -> ";"
        * f12 -> "}"
        */
    public String visit(MethodDeclaration n, String argu) throws Exception {
        String name = n.f2.f0.toString();
        String methodType = classTable.get(currentClass).methods.get(name).type;

        currentMethod = name;

        String _ret = null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);
        String exprType = n.f10.accept(this, argu);
        n.f11.accept(this, argu);
        n.f12.accept(this, argu);

        if(isMethodOfParent(currentClass, name)){
            if(!methodType.equals(tempMethodInfo.type)){
                throw new Exception("MethodDeclaration: Method " + name + " (defined in class " + currentClass + ") does not match the type of the same method defined in a parent class. Should be of type " + tempMethodInfo.type + ".");
            }
            else{
                ArrayList<String> tempArrayList = classTable.get(currentClass).methods.get(name).parameters;
                if(tempArrayList.size() != tempMethodInfo.parameters.size()){
                    throw new Exception("MethodDeclaration: Method " + name + " (defined in class " + currentClass + ") does not match the argument list of the same method defined in a parent class.");
                }
                else{
                    for(int i=0; i<tempArrayList.size(); i++){
                        if(!tempArrayList.get(i).equals(tempMethodInfo.parameters.get(i))){
                            throw new Exception("MethodDeclaration: Method " + name + " (defined in class " + currentClass + ") does not match the argument list of the same method defined in a parent class.");
                        }
                    }
                }
            }
        }

        if(!isCompatibleType(exprType, methodType)){
            throw new Exception("MethodDeclaration: Type of return value (" + exprType + ") does not match type of method (" + methodType + ").");
        }

        currentMethod = null;

        return _ret;
    }

    /**
     * f0 -> <IDENTIFIER>
     */
    public String visit(Identifier n, String argu) throws Exception {
        String name = n.f0.toString();
        String type;

        if(argu != null && argu.equals("name")) return name;

        //Order of these if-statements matters
        if(isMethodVariable(currentClass, currentMethod, name)) {
            type = tempType;
        }
        else if(isClassVariable(currentClass, name)){
            type = tempType;
        }
        else if(isVariableOfParentClass(currentClass, name)){
            type = tempType;
        }
        else {
            type = "null";
            //throw new Exception("Identifier: " + name + " has not been declared.");
        }
        n.f0.accept(this, argu);

        return type;
    }

    /**
     * f0 -> "new"
     * f1 -> "int"
     * f2 -> "["
     * f3 -> Expression()
     * f4 -> "]"
     */
    public String visit(ArrayAllocationExpression n, String argu) throws Exception {

        String exprType;

        String _ret = "int[]";
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        exprType = n.f3.accept(this, argu);
        n.f4.accept(this, argu);

        if(!(exprType.equals("int"))){
            throw new Exception("ArrayAllocation: Expression within [ ] is of type " + exprType + " instead of int.");
        }

        return _ret;
    }

   /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    public String visit(AllocationExpression n, String argu) throws Exception {

       String identifier = n.f1.f0.toString();

       if(identifier.equals("null") || classTable.get(identifier) == null){
           throw new Exception("AllocationExpression: " + identifier + " has not been declared.");
       }

       String _ret = identifier;
       n.f0.accept(this, argu);
       n.f1.accept(this, argu);
       n.f2.accept(this, argu);
       n.f3.accept(this, argu);
       return _ret;
    }

   /**
    * f0 -> "!"
    * f1 -> Clause()
    */
   public String visit(NotExpression n, String argu) throws Exception {
      n.f0.accept(this, argu);
      String _ret = n.f1.accept(this, argu);
      if(!_ret.equals("boolean")) {
          throw new Exception("NotExpression: Expression after '!' is of type " + _ret + " instead of boolean.");
      }
      return _ret;
   }

   /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
   public String visit(BracketExpression n, String argu) throws Exception {
      n.f0.accept(this, argu);
      String _ret = n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> NotExpression()
    *       | PrimaryExpression()
    */
   public String visit(Clause n, String argu) throws Exception {
      return n.f0.accept(this, argu);
   }

   /**
    * f0 -> IntegerLiteral()
    *       | TrueLiteral()
    *       | FalseLiteral()
    *       | Identifier()
    *       | ThisExpression()
    *       | ArrayAllocationExpression()
    *       | AllocationExpression()
    *       | BracketExpression()
    */
   public String visit(PrimaryExpression n, String argu) throws Exception {
      String type = n.f0.accept(this, argu);
      if(type.equals("null")){
          throw new Exception("PrimaryExpression: Variable " + n.f0.accept(this, "name") + " has not been declared.");
      }
      return type;
   }

   /**
    * f0 -> AndExpression()
    *       | CompareExpression()
    *       | PlusExpression()
    *       | MinusExpression()
    *       | TimesExpression()
    *       | ArrayLookup()
    *       | ArrayLength()
    *       | MessageSend()
    *       | Clause()
    */
   public String visit(Expression n, String argu) throws Exception {
       String type = n.f0.accept(this, null);

       if(argu != null && argu.equals("param")){
           tempParamList.add(type);
       }

      return type;
   }

   /**
    * f0 -> "this"
    */
   public String visit(ThisExpression n, String argu) throws Exception {
      n.f0.accept(this, argu);
      return currentClass;
  }

  /**
   * f0 -> "true"
   */
  public String visit(TrueLiteral n, String argu) throws Exception {
     n.f0.accept(this, argu);
     return "boolean";
  }

  /**
   * f0 -> "false"
   */
  public String visit(FalseLiteral n, String argu) throws Exception {
     n.f0.accept(this, argu);
     return "boolean";
  }

  /**
   * f0 -> <INTEGER_LITERAL>
   */
  public String visit(IntegerLiteral n, String argu) throws Exception {
     n.f0.accept(this, argu);
     return "int";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "."
   * f2 -> "length"
   */
  public String visit(ArrayLength n, String argu) throws Exception {
     String _ret=null;
     String primaryExpr = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     n.f2.accept(this, argu);
     if(primaryExpr.equals("int[]")){
         return "int";
     }
     else{
         throw new Exception("ArrayLength: length called for type " + primaryExpr + " instead of int[].");
     }
  }

  /**
   * f0 -> Clause()
   * f1 -> "&&"
   * f2 -> Clause()
   */
  public String visit(AndExpression n, String argu) throws Exception {
        String _ret=null;
        String left = n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        String right = n.f2.accept(this, argu);

        if(!left.equals("boolean")){
            throw new Exception("AndExpression: Left expression is of type " + left + " instead of boolean.");
        }
        else if(!right.equals("boolean")){
            throw new Exception("AndExpression: Right expression is of type " + right + " instead of int.");
        }
        else return "boolean";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "<"
   * f2 -> PrimaryExpression()
   */
  public String visit(CompareExpression n, String argu) throws Exception {
        String _ret=null;
        String left = n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        String right = n.f2.accept(this, argu);

        if(!left.equals("int")){
            throw new Exception("CompareExpression: Left expression is of type " + left + " instead of boolean.");
        }
        else if(!right.equals("int")){
            throw new Exception("CompareExpression: Right expression is of type " + right + " instead of boolean.");
        }
        else return "boolean";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "+"
   * f2 -> PrimaryExpression()
   */
  public String visit(PlusExpression n, String argu) throws Exception {
        String _ret=null;
        String left = n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        String right = n.f2.accept(this, argu);

        if(!left.equals("int")){
            throw new Exception("PlusExpression: Left expression is of type " + left + " instead of int.");
        }
        else if(!right.equals("int")){
            throw new Exception("PlusExpression: Right expression is of type " + right + " instead of int.");
        }
        else return "int";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "-"
   * f2 -> PrimaryExpression()
   */
  public String visit(MinusExpression n, String argu) throws Exception {
     String _ret=null;
     String left = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String right = n.f2.accept(this, argu);

     if(!left.equals("int")){
         throw new Exception("MinusExpression: Left expression is of type " + left + " instead of int.");
     }
     else if(!right.equals("int")){
         throw new Exception("MinusExpression: Right expression is of type " + right + " instead of int.");
     }
     else return "int";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "*"
   * f2 -> PrimaryExpression()
   */
  public String visit(TimesExpression n, String argu) throws Exception {
     String _ret=null;
     String left = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String right = n.f2.accept(this, argu);

     if(!left.equals("int")){
         throw new Exception("TimesExpression: Left expression is of type " + left + " instead of int.");
     }
     else if(!right.equals("int")){
         throw new Exception("TimesExpression: Right expression is of type " + right + " instead of int.");
     }
     else return "int";
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "["
   * f2 -> PrimaryExpression()
   * f3 -> "]"
   */
  public String visit(ArrayLookup n, String argu) throws Exception {
     String _ret=null;
     String intArray, index;
     intArray = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     index = n.f2.accept(this, argu);
     n.f3.accept(this, argu);

     if(!intArray.equals("int[]")){
         throw new Exception("ArrayLookup: Lookup is called for type " + intArray + " instead of int[]");
     }
     else if(!index.equals("int")){
         throw new Exception("ArrayLookup: Index of array lookup is of type " + index + " instead of int.");
     }
     else {
         return "int";
     }
  }

  /**
   * f0 -> PrimaryExpression()
   * f1 -> "."
   * f2 -> Identifier()
   * f3 -> "("
   * f4 -> ( ExpressionList() )?
   * f5 -> ")"
   */
  public String visit(MessageSend n, String argu) throws Exception {
     String _ret=null;
     String className = n.f0.accept(this, argu);
     typeOfObject.add(className);
     if(className == null || !classTable.containsKey(className)){
         throw new Exception("MessageSent: Called for class that hasn't been declared");
     }
     n.f1.accept(this, argu);
     n.f2.accept(this, argu);
     n.f3.accept(this, argu);
     n.f4.accept(this, "param");
     n.f5.accept(this, argu);

     String methodName = n.f2.f0.toString();
     if(!isMethodOfParent(className, methodName)
        && !isClassMethod(className, methodName)) {
            throw new Exception("MessageSent: Class '" + className + "' does not have method '" + methodName + "'.");
     }

     MethodInfo methodInfo = tempMethodInfo;
     //if(tempParamList.size() != methodInfo.parameters.size()){
     //    throw new Exception("MessageSent: Parameter list given for method " + methodName + " does not match the declared parameter list.");
     //}
     //else{
     //    for(int i=0; i<tempParamList.size(); i++){
     //        if(!isCompatibleType(tempParamList.get(i), methodInfo.parameters.get(i))){
     //           throw new Exception("MessageSent: In call of '" + methodName + "', parameter #" + i+1 + " is of type " + tempParamList.get(i) + " instead of " + methodInfo.parameters.get(i) + ".");
     //        }
     //    }
     //}

     tempParamList.clear();
     return methodInfo.type;
  }

  /**
   * f0 -> "if"
   * f1 -> "("
   * f2 -> Expression()
   * f3 -> ")"
   * f4 -> Statement()
   * f5 -> "else"
   * f6 -> Statement()
   */
  public String visit(IfStatement n, String argu) throws Exception {
     String _ret=null;
     n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String type = n.f2.accept(this, argu);
     n.f3.accept(this, argu);
     n.f4.accept(this, argu);
     n.f5.accept(this, argu);
     n.f6.accept(this, argu);

     if(type == null || !type.equals("boolean")){
         throw new Exception("WhileStatement: Argument given to if is of type " + type + " instead of boolean.");
     }

     return _ret;
  }

  /**
   * f0 -> "while"
   * f1 -> "("
   * f2 -> Expression()
   * f3 -> ")"
   * f4 -> Statement()
   */
  public String visit(WhileStatement n, String argu) throws Exception {
     String _ret=null;
     n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String type = n.f2.accept(this, argu);
     n.f3.accept(this, argu);
     n.f4.accept(this, argu);

     if(type == null || !type.equals("boolean")){
         throw new Exception("WhileStatement: Argument given to while is of type " + type + " instead of boolean.");
     }

     return _ret;
  }

  /**
   * f0 -> "System.out.println"
   * f1 -> "("
   * f2 -> Expression()
   * f3 -> ")"
   * f4 -> ";"
   */
  public String visit(PrintStatement n, String argu) throws Exception {
     String _ret=null;
     n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String type = n.f2.accept(this, argu);
     n.f3.accept(this, argu);
     n.f4.accept(this, argu);

     if(type == null || !type.equals("int")){
         throw new Exception("PrintStatement: Argument given to println is of type " + type + " instead of int.");
     }

     return _ret;
  }

  /**
   * f0 -> Identifier()
   * f1 -> "="
   * f2 -> Expression()
   * f3 -> ";"
   */
  public String visit(AssignmentStatement n, String argu) throws Exception {
     String _ret=null;
     String idName =  n.f0.f0.toString();
     String idType = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String exprType = n.f2.accept(this, argu);
     n.f3.accept(this, argu);

     if(idType.equals("null")){
         throw new Exception("AssignmentStatement: " + idName + " has not been declared.");
     }
     else if(!isCompatibleType(exprType, idType)){
         throw new Exception("AssignmentStatement: Assignment to " + idName + " is of type " + exprType + " instead of " + idType + ".");
     }

     return _ret;
  }

  /**
   * f0 -> Identifier()
   * f1 -> "["
   * f2 -> Expression()
   * f3 -> "]"
   * f4 -> "="
   * f5 -> Expression()
   * f6 -> ";"
   */
  public String visit(ArrayAssignmentStatement n, String argu) throws Exception {
     String _ret=null;
     String idName =  n.f0.f0.toString();
     String idType = n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     String indexType = n.f2.accept(this, argu);
     n.f3.accept(this, argu);
     n.f4.accept(this, argu);
     String exprType = n.f5.accept(this, argu);
     n.f6.accept(this, argu);

     if(idType.equals("null")){
         throw new Exception("ArrayAssignmentStatement: " + idName + " has not been declared.");
     }
     else if(!idType.equals("int[]")){
         throw new Exception("ArrayAssignmentStatement: " + idName + " is of type " + idType + " instead of int[].");
     }
     else if(!indexType.equals("int")){
         throw new Exception("ArrayAssignmentStatement: Index of array is of type " + indexType + " instead of int.");
     }
     else if (!exprType.equals("int")){
         throw new Exception("ArrayAssignmentStatement: Assignment to " + idName + "[] is of type " + exprType + " instead of int.");
     }

     return _ret;
  }

}
