#!/bin/bash

#Validar si existe tal "URL" con "httpx"

       echo -e "\n\tvalidar existente 'url'\n"
       cat sub_real.txt | httpx -silent -no-color -status-code -content-type -method -title -o url_valido.txt
       echo -e "\n\ttermino la ejecución"
       cp url_valido.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/httpx
       #rm url_valido.txt


#funtion6
#validar si existe tal "URL" con "urlprobe" 
#urlprobe(){
#       echo -e "\n\tvalidar existente 'url'\n"
#       cat $ruta/domains_vali.txtt | sort -u | anew $ruta/probe.txt
#       echo -e "\n\ttermino ña ejecucion"
#}

#fintion7
#fhc(){
#       echo -e "\n\tvalidar existente 'url'\n"
#       cat $ruta/domains_vali.txtt | sort -u | anew $ruta/fhc.txt
#       echo -e "\n\ttermino la ejecucion\n"
#}

