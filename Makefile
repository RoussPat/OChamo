
modules :
	ocamlc -c -g graph.mli graph.ml tools.mli tools.ml gfile.mli gfile.ml flow.mli flow.ml fcost.mli fcost.ml MoneySharing.mli MoneySharing.ml

rebuild :
	mrproper
	main

test : modules
	ocamlc -g -o test graph.cmo tools.cmo gfile.cmo flow.cmo test.ml

test2 : modules
	ocamlc -g -o test2 graph.cmo tools.cmo gfile.cmo flow.cmo test2.ml

MStest : modules
	ocamlc -g -o MStest graph.cmo tools.cmo gfile.cmo flow.cmo MoneySharing.cmo MStest.ml

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
	rm -rf ./_build
	rm -f test
	rm -f MoneySharing/MoneySharing
	rm -f ford-fulkerson
	rm -f ford-fulkerson-min-cost
	rm -f MStest
	rm -f test2
	rm -f *.tmp

