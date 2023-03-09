#!/bin/bash

#search file js


	cat history_url.txt | grep -iE '\.js'|grep -ivE '\.json' | hakcheckurl | grep -v 404 | sort -u  | anew fileJS.txt
       	cat fileJS.txt | awk '{print $2}' | anew js200.txt
	cp fileJS.txt js200.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/url_history
	rm fileJS.txt js200.txt
	#cat history_url.txt | subjs | fff | grep -v 404
