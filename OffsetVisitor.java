import syntaxtree.*;
import visitor.GJDepthFirst;
import java.util.*;

public class OffsetVisitor extends GJDepthFirst<String, String> {

    static public HashMap<String, OffsetInfo> offsetTable = new HashMap<String, OffsetInfo>();
    private HashMap<String, ClassInfo> classTable = GatherVisitor.classTable;

    String currentClass;
    String currentMethod;

    Integer tempOffset;

    public void init(){
        offsetTable.clear();
        tempOffset = null;
    }

    public void printOffsetInfo(){
        for(String className : offsetTable.keySet()){
            offsetTable.get(className).print();
        }
    }

    public boolean isClass(String className){
        if(className == null) return false;
        return offsetTable.containsKey(className);
    }

    public boolean extendsAnotherClass(String className){
        if(isClass(className)){
            return isClass(offsetTable.get(className).classExtends);
        }
        return false;
    }

    public boolean isMethodOfParent(String className, String methodName){
        if(extendsAnotherClass(className)){
            String classExtends = offsetTable.get(className).classExtends;
            if(offsetTable.get(classExtends).methods.contains(methodName)){
                int index = offsetTable.get(classExtends).methods.indexOf(methodName);
                tempOffset = offsetTable.get(classExtends).methodOffsets.get(index);
                return true;
            }
            else return isMethodOfParent(classExtends, methodName);
        }
        return false;
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

          OffsetInfo offsetInfo = new OffsetInfo(name,null);
          offsetTable.put(name, offsetInfo);

          String _ret=null;
          n.f0.accept(this, argu);
          n.f1.accept(this, argu);
          n.f2.accept(this, argu);
          n.f3.accept(this, "class");
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

         currentClass = name;

         Integer varOffset = 0;
         Integer metOffset = 0;
        if(offsetTable.containsKey(classExtends)){
            varOffset = offsetTable.get(classExtends).varOffset;
            metOffset = offsetTable.get(classExtends).metOffset;
        }
        OffsetInfo offsetInfo = new OffsetInfo(name, classExtends, varOffset, metOffset);
        offsetTable.put(name, offsetInfo);

        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, "class");
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        currentClass = null;

        return _ret;
    }

      /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    public String visit(VarDeclaration n, String argu) throws Exception {

        if(argu != null && argu.equals("class")){
            String name = n.f1.f0.toString();
            String type = classTable.get(currentClass).variables.get(name);
            offsetTable.get(currentClass).addNewVariable(name, type);
        }

        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);

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
        String type = classTable.get(currentClass).methods.get(name).type;

        if(!isMethodOfParent(currentClass, name)){
            offsetTable.get(currentClass).addNewMethod(name);
        }

        currentMethod = name;

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

        currentMethod = null;

        return _ret;
    }
}
