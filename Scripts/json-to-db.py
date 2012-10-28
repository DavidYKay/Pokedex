#!/usr/bin/env python

import sqlite3
import json

if __name__ == '__main__':
  # load the json into memory
  monsters = json.load(open('scraper/pokemon.json'))
  db_conn = sqlite3.connect('new.sqlite')

  with db_conn:
    c = db_conn.cursor()

    all_params = []

    # loop through all the items
    for pokemon in monsters:
      number = int(pokemon['number'])
      secondary_type = pokemon.get('secondary_type')

      primary_ability   = pokemon.get('primary_ability')
      secondary_ability = pokemon.get('secondary_ability')

      params = (
          number,
          pokemon['name'],
          pokemon['primary_type'],
          secondary_type,
          pokemon['biography'],
          primary_ability,
          secondary_ability,
      )
      print "inserting pokemon: %s" % number
      result = c.execute('INSERT INTO pokemon VALUES (?,?,?,?,?,?,?)', params)
      print "Result was: %s" % result
      #c.execute('INSERT INTO pokemon VALUES ', params)
      #all_params += params
      # insert into the DB

    #c.executemany('INSERT INTO pokemon VALUES (?,?,?,?,?)', all_params)
