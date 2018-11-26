# Compiler and Type Checker for the MiniJava language 

- MiniJava is a subset of Java that includes all the basic arithmetic operations as well as functions and classes including class inheritage.

- Implemented in Java using JavaCC and JTB.

- The type checking part of the compiler includes semantic analysis of a given MiniJava file.

- The second part is the compiler itself which parses the given code in order to generate intermediate LLVM code that is then used by the Clang LLVM compiler to produce an executable.

## Dependencies
- In order to run the code on your machine you need to have a recent version of ```java``` and ```javac``` installed.
- The easiest way to do this in a Linux distro is by using the following command:
```
sudo apt-get install default-jdk
```
- In order to execute the produced LLVM intermediate code you should install the Clang compiler. For the testing purposes of this project ```clang-4.0``` was used.
- You can install Clang by using the following command in any Linux distro:
```
sudo apt-get install clang-4.0
```
- You will also need ```make```. Most people already have it installed in their Linux distros, but if you don't, you can do so as such:
```
sudo apt-get install make
```

## Compile
From the main directory, execute:
```
make
```
to compile the code.

## Execute the compiler
From the main directory, execute
```
java Main <inputFile>
```
to compile the given ```<inputFile>``` and produce the corresponding ```.ll``` file in the ```/output``` directory.
- You can find a few MiniJava files in the ```/input``` directory

## In order to run the compiled LLVM code
If you have the ```clang-4.0``` installed on your machine, all you need to do is execute the following command:
```
clang-4.0 <fileName> -o out**
```
This will produce an executable that can be run as such:
```
./out
```

## Example
Let's say we want to compile and run the following file: ```input/Factorial.java```
- Firstly, we need to compile our project:
```
make
```
- Secondly, we want to compile ```input/Factorial.java``` using our MiniJava compiler:
```
java Main input/Factorial.java
```
- This will produce the file ```Factorial.ll``` in the ```/output``` directory
- Then we want to compile this intermediate LLVM code using Clang:
```
clang-4.0 output/Factorial.ll -o out
```
- Finally, all that is left to do is to execute the executable:
```
./out
```

