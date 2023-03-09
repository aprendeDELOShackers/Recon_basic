#!/bin/bash

#Premutation/Alterations
	gotator -sub sub_real.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md | anew permuSub
#Validar o resolver o verificar si es valido
        puredns resolve permSub -r resolvers.txtt | anew validoSub
	cp permuSub /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
	rm -rf permuSub hackerone.com.txt

#echo [+] ejecuando assetfinder ; assetfinder -subs-only testphp.vulnweb.com | tee sub.txt ; gotator -sub sub.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md > perm.txt ; puredns resolve perm.txt -r resolvers.txt | anew valido.tx

#otra manera de resolver o validar dns
#assetfinder -subs-only testphp.vulnweb.com | tail -6 | massdns -r resolvers.txt -t A -o S -w resul.txt.

