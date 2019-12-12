Bienvenue dans notre merveilleux module OCaml implémentant l'aglorythme de Ford-Fulkerson

####################################
###     Version 1 - Flot Max     ###
####################################

Format du fichier attendu :
Format des fichiers de base fourni dans le sujet du projet
Compiler les modules et le fichier a executer : make ff
Executer l'algorithme : ./ford-fulkerson [graph-file] [node-source] [node-puit]

Ce programme génère le graphe de flot avec le flot maximal dans le dossier courant (format dot) dans [nom du fichier graphe]_flow_result.svg
Il affiche pour chaque itération le chemin trouvé sous forme de liste de node et la variation de flot associée, puis le débit final.

Exemple :
./ford-fulkerson graph1 0 3
./ford-fulkerson graph2 0 5



####################################
###  Version 2 - Money Sharing   ###
####################################

Format du fichier attendu dans input.txt:
						    p [nouvelle_personne]
						    t [personne] [montant] 
						    % [commentaire]

Sortie : dans TestToExport/MoneySharing_result.svg						    
Compiler : "Make MStest"
Rq: il y a potentielement besoin de recompiler, utiliser "make mrproper" avant
Executer : ./MStest
Note : pour creer un ficher de test par vous meme regardez la structure du fichier MStest. La fonction resolve du fichier MoneySharing.ml est la fonction principale de resolution du probleme.



####################################
##  Version 3 - Flot Max Cout Min ##
####################################
Format du fichier attendu :
Même format que la version 1, avec e [node1] [node2] [capacité]-[coût]
Sortie :
Flot max et cout min du graphe donné, avec le graphe associé dans le fichier [nom du fichier graphe]_flow_cost_result.svg
Compiler : make ffcost
Executer : ./ford-fulkerson-min-cost [graph-file] [node-source] [node-puit]
Exemple : ./ford-fulkerson-min-cost graph1cost 0 7