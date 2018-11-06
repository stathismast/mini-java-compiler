class Fibonacci{
    public static void main(String[] a){
        int x;
        int y;
        int z;
        int counter;
        int[] array;

        Fibonacci fib;

        A aaaa;
        aaaa = new A();
        fib = new Fibonacci();

        array = new int[10];

        x=0;
        while(x<10){
            array[x] = x;
            x = x + 1;
        }

        System.out.println(array.length);
        System.out.println(array[0]);
        System.out.println(array[1]);
        System.out.println(array[3]);
        System.out.println(array[4]);
        System.out.println(array[5]);
        System.out.println(array[6]);
        System.out.println(array[7]);
        System.out.println(array[8]);
        System.out.println(array[((array.length)-1)]);

        System.out.println(11111111);

        array = new int[50];

        x = 0;
        y = 1;

        counter = 0;

        while(x<1000){
            System.out.println(x);
            array[counter] = x;
            counter = counter + 1;

            z = x + y;
            x = y;
            y = z;
        }

        while((0<x) && !(!(0 < counter))){
            System.out.println(array[(((counter-1)+50)-50)]);
            counter = counter - 1;
        }
    }
}

class A extends Fibonacci{

    boolean bool;
    int integer;
    int[] array;
    B objB;

    public int foo(boolean a, int aa){
        int x;

        integer = 666;
        objB = new B();

        if(bool){
            System.out.println(1);
        }
        else{
            array = new int[10];
            System.out.println(array.length);
        }
        System.out.println(aa);

        if(a){
            x = 2 * aa;
        }
        else{
            x = aa + 7;
        }

        return x;
    }

    public int bar(int a){
        System.out.println(a);
        System.out.println(integer);

        array = new int[5];
        array[2] = 666;
        System.out.println(array[2]);
        array[0] = objB.foobar();
        System.out.println(array[0]);

        return 0;
    }
}

class B extends A{
    public int bar(int aa){
        int x;
        x = aa;
        return x;
    }
    public int foo(boolean a, int aa){
        int x;

        integer = 666;
        objB = new B();

        if(bool){
            System.out.println(1);
        }
        else{
            array = new int[10];
            System.out.println(array.length);
        }
        System.out.println(aa);

        if(a){
            x = 2 * aa;
        }
        else{
            x = aa + 7;
        }

        return x;
    }

    public int barfoo(boolean b, A bb, int[] bbb){
        return 0;
    }
    public int foobar(){
        System.out.println(1234567);
        return 666;
    }
}
