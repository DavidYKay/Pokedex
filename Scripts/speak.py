#!/usr/bin/env python
""" Script for turning bios into sounds """

import json
import os
import sys


if __name__ == '__main__':
    # load the json into memory
    MONSTERS = json.load(open('scraper/pokemon.json'))

    # loop through all the items
    for pokemon in MONSTERS:
        number = int(pokemon['number'])
        bio = pokemon['biography']
        bio = bio.encode(sys.getfilesystemencoding())

        #in_path = ''
        out_path = pokemon['number']
        #command = "say -f bios/bulba-bio.txt -o pokesound/bulba.aiff" % (
        #in_path, out_path)
        command = """say "%s" -o sounds/%s.aiff""" % (bio, out_path)

        os.system(command)
