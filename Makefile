all:
	java -jar jtb132di.jar -te minijava.jj
	java -jar javacc5.jar minijava-jtb.jj
	javac Main.java GatherVisitor.java TypeCheckVisitor.java OffsetVisitor.java MethodInfo.java ClassInfo.java OffsetInfo.java
	@echo
	@echo All files compiled successfully.

compile:
	javac Main.java GatherVisitor.java TypeCheckVisitor.java OffsetVisitor.java MethodInfo.java ClassInfo.java OffsetInfo.java LLVMVisitor.java

clean:
	@rm -fr syntaxtree visitor *.class *~ JavaCharStream.java minijava-jtb.jj MiniJavaParser.java MiniJavaParserConstants.java MiniJavaParserTokenManager.java ParseException.java Token.java TokenMgrError.java 
	@echo Removed all extra files.
