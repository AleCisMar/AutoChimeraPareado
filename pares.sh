#!/usr/bin/bash
date
echo renombrando cadenas a: A
for i in $(ls *.pdb | sort); do perl -T renamepdbchain.pl -infile $i -tochain A ; done
echo creando lista de archivos PDB
ls *.pdb.pdb > lista.txt
#reemplazar el comando de arriba en caso de que no sea necesario modificar el nombre de las cadenas
#ls *.pdb > lista.txt
echo Generando lista de pares a comparar
perl pares.pl
paste out1.txt out2.txt | sed 's/	/ /g' > pares.txt
rm out*
rm lista.txt
echo Realizando comparaciones pareadas
sed 's/^/chimera --nogui /' pares.txt | sed 's/$/ alinear.py/' > alineador.sh
#reemplazar el comando de arriba en caso de que las estructuras no se encuentren previamente alineadas
#sed 's/^/chimera --nogui /' pares.txt | sed 's/$/ matchmaker.cmd alinear.py/' > alineador.sh
chmod 755 alineador.sh
rm pares.txt
bash alineador.sh > log.out
rm alineador.sh
echo Creando tabla de resultados

grep 'RMSD of' log.out | cut -d' ' -f3,7 | sed 's/  *//g' > a.txt
grep 'Evaluating' log.out | cut -d' ' -f5 > laln.txt
grep 'Overall' log.out | cut -d' ' -f3 > rmsd.txt
grep 'Q-score' log.out | cut -d' ' -f 2 > qscore.txt
grep 'SDM' log.out | cut -d' ' -f4 > sdm.txt
paste *.txt | sed 's/	/,/g' | sed 's/,,/,/g' > tabla.csv
rm *.txt
echo FIN
date