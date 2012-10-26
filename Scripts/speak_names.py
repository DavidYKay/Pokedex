#!/usr/bin/env python
""" Script for turning bios into sounds """

import json
import os
import sys


if __name__ == '__main__':
    # load the json into memory
    MONSTERS = json.load(open('scraper/pokemons.json'))

    # loop through all the items
    for pokemon in MONSTERS:
        number = int(pokemon['number'])
        name = pokemon['name']
        name = name.encode(sys.getfilesystemencoding())

        out_path = pokemon['number']
        command = """say "%s" -o names/%s.aiff""" % (name, out_path)
        print "executing command: %s" % command

        os.system(command)
