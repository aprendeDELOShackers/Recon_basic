#****_Pequeño script en bash para automatizar la enumeracion de subdominio_****

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

# ****_BforceSub.sh_****

    #!/bin/bash

    #Ejecución de puredns:
    #Antes de ejecutar puredns debemos de generar el "resolvers dns publico" Para ellos uzaremos la herramienta
    #dnsvalidator# para obt info de "resoluctores dns publico" que son importante

    #Resolutor de DNS publico podemos encontar en "https://public-dns .info/nameservers.txt"
    domain=$1
    wordlists=/usr/share/wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
    valid_dns(){
      mkdir -p $domain/dsnResolve $domain/brute_force $domain/sub
      dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 100 -o $domain/dnsResolve/resolvers.txt
    }
    valid_dns

    puredns(){
      puredns bruteforce $wordlists $domain -r $domain/dnsResolve/resolvers.txt -w $domain/brute_force/posiSub.txt
      xargs -a posiSub.txt -I@ sh -c 'subfinder -d @ | anew $domain/brute_force/xargs.txt'
      cat $domain/brute_force/xargs.txt | anew $domain/brute_force/posiSub.txt
    }
    puredns

    #validar subdomain
    DNS_resolving(){

      puredns resolve $domain/brute_force/posiSub.txt -r $domain/dnsResolve/resolvers.txt | anew $domain/sub/sub_vali.txt
      cp $domain/sub/sub_vali.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
      rm -fr $domain
    }
    DNS_resolving
  
  
#****_permu.sh_****
    
    #!/bin/bash

    #Premutation/Alterations
      gotator -sub sub_real.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md | anew permuSub
    #Validar o resolver o verificar si es valido
            puredns resolve permSub -r resolvers.txtt | anew validoSub
      cp permuSub /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
      rm -rf permuSub hackerone.com.txt
    
    #de forma directa usando "assetfinder"
     echo [+] ejecuando assetfinder ; assetfinder -subs-only testphp.vulnweb.com | tee sub.txt ; gotator -sub sub.txt -perm permutations.txtt -depth 1 -numbers 10 -mindup -adv -md > perm.txt ; puredns resolve perm.txt -r resolvers.txt | anew valido.tx

    #otra manera de resolver o validar dns usando assetfinder y massdns
    assetfinder -subs-only testphp.vulnweb.com | tail -6 | massdns -r resolvers.txt -t A -o S -w resul.txt.


#****_scrapi_sour_code.js.sh_****

    #!/bin/bash

    #Scraping(JS/source code) o raspado(JS/codigo fuente)
    #corrindo gospider ====> Este proseso se divide en tres parte
    #1)Subdomio de Sondeo Web
    #2)Limpiesa de Salida
    #3)Resolver nuestro dominio del destino

    #1)Subdomio de Sondeo Web
      cat sub_real.txt | httpx -random-agent -retries 2 -no-color | anew urlpro.txt

    #-S, --sites | -t, --threads | #-w, --include-subs | -d, --depth | -r, --include-other-source
      gospider -S urlpro.txt --js -t 50 -d 3 --sitemap --robots -w -r | anew  gos_js.txt
    #2)Limpiesa de Salida
      cat gos_js.txt | sed '/^.\{2048\}./d' > gosprob.txt;
      gosprob.txt | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep 'hackerone.com' | sort - u | anew gospiderSub.txt
      cp gospiderSub.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
      rm -fr urlpro.txt gos_js.txt gosprob.txt gospiderSub.txt 
    #3)Resolver nuestro dominio del destino
      puredns resolve sub.txt -w S_real.txt -r $resolvers
      cp S_real.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
      rm -rf sub_real.txt urlpro.txt gos_js.txt gosprob.txt sub.txt S_real.txt

      #Scraping(JS/source code) o raspado(JS/codigo fuente) aplicar de forma directa 
     echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only |  tee sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color | tee http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r | tail -1000 | anew gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4

     echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only > sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color > http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r > gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4
    

#****_google_analitics_sub_****
    
    #!/bin/bash

    #GOOGLE ANALITIC con "BuiltWidth" es una extension
    #Utilizamos una tools en lineas de comando llamado "AnaliticsRelationships"
    domain=$1

    AnaliticsRelationships(){
      mkdir -p $domain $domain/sub
      analyticsrelationships --url $domain | anew $domain/sub/subdomain.txt
      cat $domain/sub/subdomain.txt  | awk '{print $2}' | grep '.hackerone.com' | anew  $domain/sub/analitics
      cp $domain/sub/analitics /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
      rm -rf $domain
    }
    AnaliticsRelationships

    #validar dns
    puredns(){
   	puredns resolve $domain/sub/subdomain.txt -w $domain/sub/sub_real.txt -r $resolvers
   	cat $domain/sub/sub_real.txt
    }
    puredns

    #analyticsrelationships -u hackerone.com > tests ; cat tests | awk '{print $2}' | grep "hackerone.com"


#****_url_probe.sh_****
    
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


#****_nuclei.sh_****
   
      #!/bin/bash
      #nuclei nos ayudará a descubrir fallas en un determinado url expuesto

      cat url_valido.txt | nuclei -t /root/nuclei-templates/ -etags sqli.xss,rce -c 50 -o vuln-nuclei.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/ -severity low,medium,high,critical -c 50 -o vuln-nuclei.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/ -c 50 -o nuclei-tmplates.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/cves/ -c 50 -o cves.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/vulnerabilities/ -c 50 -o vulnerabilities.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/technologies/ -c 50 -o technologies.txt
      cat url_valido.txt | nuclei -t /root/nuclei-templates/file/ -c 50 -o file.txt

      cp vuln-nuclei.txt nuclei-tmplates.txt cves.txt vulnerabilities.txt technologies.txt file.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/nuclei
      rm search-nuclei.txt nuclei-tmplates.txt cves.txt vulnerabilities.txt technologies.txt file.txt
      #ejecutar nuclei de forma rapida
      nuclei -u https://example.com -tags cve -severity critical,high -author geeknik


#****_url_history.sh_****
    
    #!/bin/bash

    #crawling url_history recolectar todos las antiguas url

      cat sub_real.txt | waybackurls | anew wayback.txt
      cat wayback.txt | egrep -v "(\.jpg|\.jpeg|\.git|\.css|\.tif|\.tiff|\.png|\.ttf|\.wolf|\.wolf2|\.ico|\.pdf|\.svg|\.txt|\.html)" | sed 's/:80//g;s/:443//g' | anew way_filter.txt
      cp wayback.txt way_filter.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/url_history
      rm wayback.txt way_filter.txt


    #      cat sub_real.txt | gau-plus | anew gau-plus.txt;
    #        cat gau-plus | egrep -v "(\.jpg|\.jpeg|\.git|\.css|\.tif|\.tiff|\.png|\.ttf|\.wolf|\.wolf2|\.ico|\.pdf|\.svg|\.txt|\.html)" | sed 's/:80//g;s/:443//g' | anew gau_filter.txt
    #        cp gau-plus.txt gau_filter.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/url_history
    #        rm gau-plus.txt gau_filter.txt


    #      cat sub_real.txt | gau | anew gau.txt;
    #        cat gau.txt | egrep -v "(\.jpg|\.jpeg|\.git|\.css|\.tif|\.tiff|\.png|\.ttf|\.wolf|\.wolf2|\.ico|\.pdf|\.svg|\.txt|\.html)" | sed 's/:80//g;s/:443//g' | anew gau_filter.txt
    #        cp gau.txt gau_filter.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/url_history
    #        rm gau.txt gau_filter.txt


#****_gf.sh_****

   #!/bin/bash

    #gf para buscar parametro en la url e inyectar payload

      gf xss way_filter.txt | anew xss.txt
      gf sqli way_filter.txt | anew sqli.txt
      gf ssrf way_filter.txt | anew ssrf.txt
      gf idor way_filter.txt | anew idor.txt
      gf lfi way_filter.txt | anew lfi.txt
      gf json-sec way_filter.txt | anew json-sec.txt

      cp xss.txt sqli.txt ssrf.txt idor.txt lfi.txt json-sec.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/gf
      rm xss.txt sqli.txt ssrf.txt idor.txt lfi.txt json-sec.txt


#****_genere_dict.sh_****
    
    #!/bin/bash

                             #genere_dict (unfurl=paths/parameters) de way
            cat way_filter.txt | unfurl -unique paths > pahts.txt
            cat way_filter.txt | unfurl -unique keys > keys.txt

      cp pahts.txt keys.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/generet_dict
      rm pahts.txt keys.txt
      

#****_file_js.sh_****

    #!/bin/bash

    #search file js


      cat history_url.txt | grep -iE '\.js'|grep -ivE '\.json' | hakcheckurl | grep -v 404 | sort -u  | anew fileJS.txt
            cat fileJS.txt | awk '{print $2}' | anew js200.txt
      cp fileJS.txt js200.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/url_history
      rm fileJS.txt js200.txt
      #cat history_url.txt | subjs | fff | grep -v 404


#****_ip.sh _****

    #!/bin/bash

            cat sub_real.txt |  massdns -r resolvers.txtt -t A -o S -w massd.txt
            gf ip massd.txt | anew > ip.txt
      cp massd.txt ip.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/ip


      #for i in $(cat sub_real.txt);do dig +short $i | grep -E "[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.";done










