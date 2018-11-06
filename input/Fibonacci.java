class Fibonacci{
    public static void main(String[] a){
        int x;
        int y;
        int z;
        int counter;
        int[] array;

        int size;
        size = 50;

        array = new int[size];

        x = 0;
        y = 1;

        counter = 0;

        while(x<100000){
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
