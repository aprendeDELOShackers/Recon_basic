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





#nuclei -u https://example.com -tags cve -severity critical,high -author geeknik

