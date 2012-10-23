# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/topics/items.html

from scrapy.item import Item, Field

########################################

class PokemonListing(Item):
  # define the fields for your item here like:
  name = Field()
  number = Field()
  primary_type = Field()
  secondary_type = Field()
  small_icon = Field()
  large_icon = Field()
  
########################################
