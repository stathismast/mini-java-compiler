import java.util.*;

public class MethodInfo{
    String name;
    String type;
    HashMap<String, String> variables = new HashMap<String, String>();
    ArrayList<String> parameters = new ArrayList<String>();

    public MethodInfo(String name, String type){
        this.name = name;
        this.type = type;
    }

    public MethodInfo(String name, String type, Map<String, String> map){
        this.name = name;
        this.type = type;
        variables.putAll(map);
    }

    public void print(){
        String params = "";
        for(int i=0; i<parameters.size(); i++){
            params = params + parameters.get(i);
            if(i+1 < parameters.size()) params = params + ", ";
        }
        System.out.println("        " + type + " " + name + "(" + params + ")");

        System.out.println("           Variables:");
        for(String name : variables.keySet()){
            String type = variables.get(name);
            System.out.println("                " + type + " " + name);
        }
    }
}
