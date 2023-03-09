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



