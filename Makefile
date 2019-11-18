
modules :
	ocamlc -c -g graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml flow.mli flow.ml

main: modules
	ocamlc -g -o ftest graph.cmo gfile.cmo tools.cmo flow.cmo ftest.ml

byte:
	ocamlbuild ftest.byte

native:
	ocamlbuild ftest.native

rebuild :
	mrproper
	main

test : modules
	ocamlc -g -o test graph.cmo gfile.cmo tools.cmo flow.cmo test.ml

test2 : modules
	ocamlc -g -o test2 graph.com gfile.cmo tools.cmo flow.cmo test2.ml

mrproper: 
	rm -f *.cmo
	rm -f *.cmi
	rm -f ftest
	rm -f ftest.byte
	rm -f ftest.native
	rm -rf ./_build
	rm -f test
