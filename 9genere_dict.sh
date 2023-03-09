#!/bin/bash

	                       #genere_dict (unfurl=paths/parameters) de way
        cat way_filter.txt | unfurl -unique paths > pahts.txt
        cat way_filter.txt | unfurl -unique keys > keys.txt

	cp pahts.txt keys.txt /home/josema96/HackerOne/program_bash/Recon_sub/mi_metodologia/hackerone.com/generet_dict
	rm pahts.txt keys.txt
