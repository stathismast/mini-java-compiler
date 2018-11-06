class Addition{
    public static void main(String[] a){
        int w;
        int x;
        int y;
        int z;
        boolean b;
        boolean b2;
        w = 1;
        x = 10;
        y = 50;
        z = 100;
        b = x<y;
        b2 = z<y;
        if(w<(x-(w*10))){
            System.out.println(1);
        }
        else{
            if(b){
                System.out.println(2*10);
            }
            else{
                System.out.println(3);
            }
        }
        if(true){
            if(b2){
                System.out.println(4);
            }
            else{
                System.out.println(x);
            }
        }
        else{
            System.out.println(6);
        }

        while(w<5){
            w = w + 1;
            System.out.println(w);
        }
    }
}
