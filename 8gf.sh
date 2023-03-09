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


