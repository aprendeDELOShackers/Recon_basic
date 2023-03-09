
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
	#puredns resolve sub.txt -w S_real.txt -r $resolvers
	#cp S_real.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/sub
	#rm -rf sub_real.txt urlpro.txt gos_js.txt gosprob.txt sub.txt S_real.txt




#echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only |  tee sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color | tee http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r | tail -1000 | anew gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4

#echo [+] ejecutando assetfinder [+] ; echo "testphp.vulnweb.com" | assetfinder -subs-only > sub.txt1 ; cat sub.txt1 ; httpx -silent -random-agent -retries 2 -no-color > http.txt2 ; gospider -S http.txt2 --js -t 50 -d 1 --sitemap --robots -w -r > gos.txt3 ; cat gos.txt3 | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | anew subvalido.txt4

