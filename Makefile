

main: 
	ocamlc -c graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml
	ocamlc -o ftest graph.cmo gfile.cmo tools.cmo ftest.ml

byte:
	ocamlbuild ftest.byte

native:
	ocamlbuild ftest.native

rebuild :
	mrproper
	main

mrproper: 
	rm -f *.cmo
	rm -f *.cmi
	rm -f ftest
	rm -f ftest.byte
	rm -f ftest.native
	rm -rf ./_build