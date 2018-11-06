import java.util.*;

public class ClassInfo{
    String name;
    String classExtends;
    LinkedHashMap<String, String> variables = new LinkedHashMap<String, String>();
    LinkedHashMap<String, MethodInfo> methods = new LinkedHashMap<String, MethodInfo>();

    public ClassInfo(String name, String classExtends){
        this.name = name;
        this.classExtends = classExtends;
    }

    public void print(){
        System.out.println();
        System.out.println("Class: " + name);
        if(classExtends != null){
                System.out.println("Extends: " + classExtends);
        }

        System.out.println("    Variables:");
        for(String name : variables.keySet()){
            String type = variables.get(name);
            System.out.println("            " + type + " " + name);
        }
        System.out.println("    Methods:");
        for(String name : methods.keySet()){
            methods.get(name).print();
        }
    }
}
