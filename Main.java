import syntaxtree.*;
import visitor.*;
import java.io.*;

public class Main {

    public static GatherVisitor gatherVisitor;
    public static TypeCheckVisitor typeCheckVisitor;
    public static OffsetVisitor offsetVisitor;
    public static LLVMVisitor llvmVisitor;
    public static BufferedWriter bw;
    public static File file;
    public static FileWriter fw;
    public static boolean afterGather;

    public static void main (String [] args){
        if(args.length < 1){
            System.err.println("Usage: java Main <inputFile>*");
            System.exit(1);
        }
        FileInputStream fis = null;
        for(int i=0; i<args.length; i++){
            try{
                fis = new FileInputStream(args[i]);

                MiniJavaParser parser = new MiniJavaParser(fis);
                Goal goal = parser.Goal();

                afterGather = false;

                gatherVisitor = new GatherVisitor();
                gatherVisitor.init();
                goal.accept(gatherVisitor, null);

                afterGather = true;

                typeCheckVisitor = new TypeCheckVisitor();
                typeCheckVisitor.init();
                goal.accept(typeCheckVisitor, null);

                offsetVisitor = new OffsetVisitor();
                offsetVisitor.init();
                goal.accept(offsetVisitor, null);

                File file = new File("output/" + args[i].substring(args[i].lastIndexOf("/")+1, args[i].lastIndexOf(".")) + ".ll");
                if(!file.exists()){
                    file.createNewFile();
                }
                fw = new FileWriter(file);
                bw = new BufferedWriter(fw);
                llvmVisitor = new LLVMVisitor(bw);
                llvmVisitor.init();
                goal.accept(llvmVisitor, null);
                
                System.out.println(args[i].substring(args[i].lastIndexOf("/")+1, args[i].lastIndexOf(".")) + ".ll compiled successfully.");
            }
            catch(ParseException ex){
                System.out.println(ex.getMessage());
            }
            catch(FileNotFoundException ex){
                System.err.println(ex.getMessage());
            }
            catch(Exception ex){
                System.err.println(ex.getMessage());
                printErrorInfo();
            }
            finally{
                try{
                    if(fis != null) fis.close();
                    }
                    catch(IOException ex){
                    System.err.println(ex.getMessage());
                }

                try{
                    if(bw != null){
                        bw.close();
                    }
                }
                catch(Exception ex){
                        System.err.println(ex.getMessage());
                }
            }
        }
    }

    public static void printErrorInfo(){
        if(afterGather){
            if(typeCheckVisitor != null)
                if(typeCheckVisitor.currentMethod != null) System.out.println("Exception thrown at class " + typeCheckVisitor.currentClass + " and method " + typeCheckVisitor.currentMethod + ".");
                else if(typeCheckVisitor.currentClass != null)System.out.println("Exception thrown at class " + typeCheckVisitor.currentClass + ".");
        }
        else{
            if(gatherVisitor != null)
                if(gatherVisitor.currentMethod != null) System.out.println("Exception thrown at class " + gatherVisitor.currentClass + " and method " + gatherVisitor.currentMethod + ".");
                else if(gatherVisitor.currentClass != null)System.out.println("Exception thrown at class " + gatherVisitor.currentClass + ".");
        }
    }
}
