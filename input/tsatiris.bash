#!/usr/bin/env bash

for i in *.java
do
    echo "Compiling $i with javac..."
    javac "$i"
    echo "Compiling $i with clang..."
    clang-4.0 "${i%.java}.ll" -o a.out
    echo ""
    echo "Javac compiled output:"
    java ${i%.java}
    echo "Your output:"
    ./a.out
done

rm ./a.out
rm *.class