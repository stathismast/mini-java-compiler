class FunsAsParams{
    public static void main(String[] a){
        A objA;
        B objB;
        boolean call;

        objA = new A();
        call = objA.set(1);

        objB =  new B();
        call = objB.set(2);

        System.out.println(objA.foo(objA, objB));
        System.out.println(objA.bar(objA.add(objA.get(), objB.get()), objA.add(1,objB.add(objB.add(1,1),1))));
    }
}

class A{

    int x;

    public boolean set(int i){
        x = i;
        return true;
    }

    public int get(){
        return x;
    }

    public int add(int l, int r){
        return l+r;
    }

    public int foo(A a1, A a2){
        System.out.println(a1.get());
        System.out.println(a2.get());
        return 111111111;
    }

    public int bar(int i1, int i2){
        System.out.println(i1);
        System.out.println(i2);
        return 222222222;
    }
}

class B extends A{

}
