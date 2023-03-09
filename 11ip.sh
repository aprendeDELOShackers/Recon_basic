#!/bin/bash

        cat sub_real.txt |  massdns -r resolvers.txtt -t A -o S -w massd.txt
        gf ip massd.txt | anew > ip.txt
	cp massd.txt ip.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/ip


	#for i in $(cat sub_real.txt);do dig +short $i | grep -E "[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.";done
