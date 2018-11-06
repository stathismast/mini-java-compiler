import syntaxtree.*;
import visitor.GJDepthFirst;
import java.util.*;

public class GatherVisitor extends GJDepthFirst<String, String> {

    static public HashMap<String, ClassInfo> classTable = new HashMap<String, ClassInfo>();

    String currentClass;
    String currentMethod;

    public void init(){
        classTable.clear();
    }

    public void printClassInfo(){
        for(String className : classTable.keySet()){
            classTable.get(className).print();
        }
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

         if(classTable.containsKey(name)){
             throw new Exception("ClassDeclaration: Redeclaration of class " + name + ".");
         }

         ClassInfo classInfo = new ClassInfo(name,null);
         classTable.put(name, classInfo);

         String _ret=null;
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
            throw new Exception("ClassExtendsDeclaration: " + name + " extends " + classExtends + ", class " + classExtends + " must be defined before " + name + ".");
        }

        currentClass = name;

        if(classTable.containsKey(name)){
            throw new Exception("ClassExtendsDeclaration: Redeclaration of class " + name + ".");
        }

        ClassInfo classInfo = new ClassInfo(name,classExtends);
        classTable.put(name, classInfo);

        String _ret=null;
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

        ClassInfo classInfo = new ClassInfo(name,null);
        classTable.put(name, classInfo);

        currentMethod = "main";
        MethodInfo methodInfo = new MethodInfo(currentMethod, "void");
        methodInfo.variables.put(n.f11.f0.toString(), "String[]");
        methodInfo.parameters.add("String[]");
        classTable.get(currentClass).methods.put(currentMethod, methodInfo);

        String _ret=null;
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
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    public String visit(VarDeclaration n, String argu) throws Exception {

        String type;
        String name = n.f1.f0.toString();

        String _ret=null;
        type = n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);

        if(currentClass != null){
            if(currentMethod != null){
                if(classTable.get(currentClass).methods.get(currentMethod).variables.get(name) == null)
                    classTable.get(currentClass).methods.get(currentMethod).variables.put(name, type);
                else
                    throw new Exception("Redeclaration of variable '" + name + "' in method " + currentMethod + "() from class " + currentClass);
            }
            else{
                if(classTable.get(currentClass).variables.get(name) == null)
                    classTable.get(currentClass).variables.put(name, type);
                else
                    throw new Exception("Redeclaration of variable '" + name + "' from class " + currentClass);
            }
        }
        else throw new Exception();

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
        String type;
        String name = n.f2.f0.toString();

        currentMethod = name;

        String _ret=null;
        n.f0.accept(this, argu);
        type = n.f1.accept(this, argu);

        MethodInfo methodInfo = new MethodInfo(name, type);
        if(classTable.get(currentClass).methods.containsKey(name)){
            throw new Exception("MethodDeclaration: Redeclaration of method " + name + " in class " + currentClass + ".");
        }
        classTable.get(currentClass).methods.put(name, methodInfo);


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

        currentMethod = null;

        return _ret;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
    public String visit(FormalParameter n, String argu) throws Exception {

        String type;
        String name = n.f1.f0.toString();

        String _ret=null;
        type = n.f0.accept(this, argu);
        n.f1.accept(this, argu);

        if(currentClass != null && currentMethod != null){
            classTable.get(currentClass).methods.get(currentMethod).variables.put(name, type);
            classTable.get(currentClass).methods.get(currentMethod).parameters.add(type);
        }
        else throw new Exception();

        return _ret;
   }

   /**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
   public String visit(Type n, String argu) throws Exception {
      return n.f0.accept(this, argu);
   }

   /**
    * f0 -> "int"
    * f1 -> "["
    * f2 -> "]"
    */
   public String visit(ArrayType n, String argu) throws Exception {
      String _ret = "int[]";
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "boolean"
    */
   public String visit(BooleanType n, String argu) throws Exception {
       n.f0.accept(this, argu);
       return "boolean";
   }

   /**
    * f0 -> "int"
    */
   public String visit(IntegerType n, String argu) throws Exception {
      n.f0.accept(this, argu);
      return "int";
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public String visit(Identifier n, String argu) throws Exception {
      n.f0.accept(this, argu);
      return n.f0.toString();
   }

}
