#!/bin/bash

#Autor= "Nu||d3v"==============="new_day_is"


#Automatization for Search subdomaind === "amass","assetfinder","findomain","subfinder","sublist3r","crobat","turbolist3r.py","ctfr.py","anubis","acamar.py","github-subdomains.oy","shuffledns","cencys-subdomain.py"

dominio=$1
resolvers=/home/josema96/HackerOne/hunters_tools/resolvers.txt

#funtion1
Help(){
  echo -e "\n\tRcon_Scriptkiddie.sh"
  echo -e "\n\tEjemplo de ejecución de la herramienta"
  echo -e "\n\t./subLyJ.sh"
}

#funtion2
vali_domain(){
  host $dominio > /dev/null 2>&1
}

#funtion3
subdomain(){
  mkdir -p $dominio $dominio/sub $dominio/httpx

  #echo -e "\n\tsearch subdomains con 'amass\n'";
  #amass enum -d $dominio | sort -u | anew $ruta/amass.txt;
  #echo -e "\ntermino la ejecution 'amass'\n";
  echo -e "\n\tsearch subdomains con 'assetfinder'\n";
  assetfinder --subs-only $dominio | sort -u | anew $dominio/sub/asset.txt;
  echo -e "\n\ttermino la ejecution con 'assetfinder'\n";
  echo -e "\n\tsearch subdomains con 'findomain'\n";
  findomain --output -t $dominio 2> /dev/null ; cp $(pwd)/*.txt $dominio/sub ; rm $(pwd)/*.txt;
  #findomain -t $dominio | sort -u | anew $dominio/sub/findo.txt;
  echo -e "\n\ttermino la ejecution con 'findomain'\n";
  echo -e "\n\tsearch subdomains con 'subfinder'\n";
  subfinder -d $dominio | sort -u | anew $dominio/sub/subfin.txt;
  echo -e "\n\ttermino la ejecution con 'subfinder'\n";
  echo -e "\n\tsearch subdomains con 'sublist3r'\n";
  sublist3r -d $dominio -o $dominio/sub/sublis.txt;
  echo -e "\n\ttermino la ejecution con 'sublist3r'\n";
  echo -e "\n\tsearch subdomains con 'crobat'\n";
  crobat -s $dominio | sort -u | anew $dominio/sub/crob.txt;
  echo -e "\n\ttermino la ejecution con 'crobat'\n";
  echo -e "\n\tsearch subdomains con 'turbolist3r'\n";
  turbolist3r.py -d $dominio -o $dominio/sub/turbo.txt;
  echo -e "\n\ttermino la ejecution con 'turbolist3r'\n";
  echo -e "\n\tsearch subdomains con 'ctfr.py'\n";
  ctfr.py -d $dominio -o $dominio/sub/ctfr.txt;
  echo -e "\n\ttermino la ejecution con 'ctfr.py'\n";
  echo -e "\n\tsearch subdomains con 'anubis'\n";
  anubis -t $dominio  -S | sort -u | anew $dominio/sub/anub.txt;
  echo -e "\n\ttermino la ejecution con 'anubis'\n";
  #echo -e "\n\tsearch subdomains con 'github-subdomains.py'\n";
  #github-subdomains.py -t {token} -d $dominio | sort -u | anew $dominio/sub/git_su.txt;
  #echo -e "\n\ttermino la ejecution con 'github-subdomains.py'\n";
  #echo -e "\n\tsearch subdomains con 'cencys-subdomain.py'\n";
  #censys-subdomain.py --censys-api-id d....-3bef-4...-a...-ac.... --censys-api-secret wYSZz8VA9....  $dominio | sort -u | anew $dominio/sub/cen_sub.txt;
  #echo -e "\n\ttermino la ejecution con 'cencys-subdomain.py'\n";
  echo -e "\n\tguardando todo los sub all 'allSub'\n"
  cat $dominio/sub/*.txt | sort -u | anew $dominio/sub/allSub ; #rm $dominio/sub/*.txt;
  echo -e "\n\tsearch subdominio dentro de un subdominio\n"
  xargs -a allSub -I@ sh -c 'subfinder -d @ -silent | anew $dominio/sub/xargs.txt'; 
  cat $dominio/sub/xargs.txt | anew $dominio/sub/allSub
  echo -e "\n\tcompletado\n"
  cp $dominio/sub/allSub /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia

}

#resol_Domain(){
  #echo -e "\n\tValidando resolvers DNS con 'shuffledns'\n"
  #xargs -a $dominio/sub/allsub -I@ sh -c 'puredns resolve @ -w $domain/sub/sub_real.txt -r $resolvers'
  #puredns resolve $dominio/sub/allSub -w $domain/sub/sub_real.txt -r $resolvers
  #echo -e "\n\tsubdomain validando con exito con 'puredns'\n"
  cp $dominio/sub/sub_real.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia
#}


#funtion8
#main call funtions
if [ "$#" == "1" ];then
  vali_domain
  if [ "$(echo $?)" == "0" ];then
    subdomain
    resol_Domain
  else
    echo -e "\nno es un dominio"
  fi
else
  Help

fi