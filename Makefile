
modules :
	ocamlc -c -g graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml

main: modules
	ocamlc -g -o ftest graph.cmo gfile.cmo tools.cmo ftest.ml

byte:
	ocamlbuild ftest.byte

native:
	ocamlbuild ftest.native

rebuild :
	mrproper
	main

test : modules
	ocamlc -g -o test graph.cmo gfile.cmo tools.cmo test.ml

mrproper: 
	rm -f *.cmo
	rm -f *.cmi
	rm -f ftest
	rm -f ftest.byte
	rm -f ftest.native
	rm -rf ./_build
	rm -f test