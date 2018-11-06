import java.util.*;

public class OffsetInfo{
    String name;
    String classExtends;
    ArrayList<String> variables = new ArrayList<String>();
    ArrayList<Integer> variableOffsets = new ArrayList<Integer>();
    ArrayList<String> methods = new ArrayList<String>();
    ArrayList<Integer> methodOffsets = new ArrayList<Integer>();

    Integer varOffset;
    Integer metOffset;

    public OffsetInfo(String name, String classExtends){
        this.name = name;
        this.classExtends = classExtends;
        varOffset = 0;
        metOffset = 0;
    }

    public OffsetInfo(String name, String classExtends, Integer varOffset, Integer metOffset){
        this.name = name;
        this.classExtends = classExtends;
        this.varOffset = varOffset;
        this.metOffset = metOffset;
    }

    public void addNewVariable(String varName, String type){
        variables.add(varName);
        variableOffsets.add(varOffset);

        varOffset += getOffset(type);
    }

    public void addNewMethod(String metName){
        methods.add(metName);
        methodOffsets.add(metOffset);
        metOffset+=8;
    }

    public int getOffset(String type){
        if(type.equals("int")){
            return 4;
        }
        else if(type.equals("boolean")){
            return 1;
        }
        else{
            return 8;
        }

    }

    public void print(){
        System.out.println();
        System.out.println("-----------Class "  + name + "----------- ");

        System.out.println("--Variables--");
        for(int i=0; i<variables.size(); i++){
            System.out.println(name + "." + variables.get(i) + ":" + variableOffsets.get(i));
        }
        System.out.println("--Methods--");
        for(int i=0; i<methods.size(); i++){
            System.out.println(name + "." + methods.get(i) + ":" + methodOffsets.get(i));
        }
    }
}
