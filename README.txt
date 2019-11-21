Bienvenue dans notre merveilleux module OCaml implémentant l'aglorythme de Ford-Fulkerson

Version 1 - Flot Max:

Format du fichier attendu :
Format des fichiers de base fourni dans le sujet du projet
Compiler les modules et le fichier a executer : make ff
Executer l'algorithme : ./ford-fulkerson [graph-file] [node-source] [node-puit]

Ce programme génère le graphe de flot avec le flot maximal dans le dossier courant (format svg et dot)
Il affiche pour chaque itération le chemin trouvé sous forme de liste de node et la variation de flot associée, puis le débit final.

Exemple :
./ford-fulkerson graph1 0 3



Version 2 - Money Sharing :

Format du fichier attendu :
Compiler :
Executer :
Exemple :


Version 3 - Flot Max Cout Min :

Format du fichier attendu :
Même format que la version 1, avec e [node1] [node2] [capacité]-[coût]

Compiler : make ffcost
Executer : ./ford-fulkerson-min-cost [graph-file] [node-source] [node-puit]
Exemple :