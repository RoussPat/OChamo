
modules :
	ocamlc -c -g graph.mli graph.ml tools.mli tools.ml gfile.mli gfile.ml flow.mli flow.ml fcost.mli fcost.ml

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
	ocamlc -g -o test graph.cmo tools.cmo gfile.cmo flow.cmo test.ml

test2 : modules
	ocamlc -g -o test2 graph.cmo tools.cmo gfile.cmo flow.cmo test2.ml

ff : modules
	ocamlc -g -o ford-fulkerson graph.cmo tools.cmo gfile.cmo flow.cmo ford-fulkerson.ml

ffcost : modules
	ocamlc -g -o ford-fulkerson-min-cost graph.cmo tools.cmo gfile.cmo fcost.cmo ford-fulkerson-min-cost.ml

MoneySharing : modules
	ocamlc -g -o MoneySharing graph.cmo tools.cmo gfile.cmo flow.cmo MoneySharing.ml

mrproper: 
	rm -f *.cmo
	rm -f *.cmi
	rm -f *.dot
	rm -f *.svg
	rm -f *.tmp
	rm -f ftest
	rm -f ftest.byte
	rm -f ftest.native
	rm -rf ./_build
	rm -f test
