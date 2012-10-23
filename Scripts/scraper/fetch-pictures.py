#!/usr/bin/env python

import urlparse
import os.path
import json
import requests

from PIL import Image
from StringIO import StringIO

#def url_to_filename(image_url):
#  path = urlparse.parse('http://www.mydomain.com/hithere/something/else').path
#  os.path.split(path)
#  return filename

def make_filename(pokemon):
  return "pictures/%s.png" % pokemon['number'][0]

def download_image(pokemon):
  r = requests.get(pokemon['large_icon'][0])
  i = Image.open(StringIO(r.content))
  i.save(make_filename(pokemon), "PNG")

if __name__ == '__main__':
  # load the json into memory
  monsters = json.load(open('pokemons.json'))

  # loop through all the items
  for pokemon in monsters:
    # fetch the image to the images folder
    #download_image(pokemon['large_image'])
    download_image(pokemon)
