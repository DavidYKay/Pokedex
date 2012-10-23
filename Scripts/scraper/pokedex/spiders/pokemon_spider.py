from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector

from pokedex.items import PokemonListing

class PokemonSpider(BaseSpider):
  name = "pokemon"
  allowed_domains = ["bulbapedia.bulbagarden.net"]
  start_urls = [
      #"http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number",
      "file:///Users/dk/workspace/current/Pokedex/Scripts/scraper/html/pokedex.html",
  ]

  def parse(self, response):
    hxs = HtmlXPathSelector(response)

    #pokemon_list_query = "//table[3]/tbody[1]/tr"
    pokemon_list_query = "//table[3]/tr"

    #first_pokemon_query = "//table[3]/tbody[1]/tr[2]"

    monsters = hxs.select(pokemon_list_query)[1:]
    items = []
    for monster in monsters:
      item = PokemonListing()
      item['number']         = monster.select('td[2]/text()').extract()
      item['small_icon']     = monster.select('td[3]/span/a/img/@src').extract()
      item['name']           = monster.select('td[4]/a/text()').extract()
      item['primary_type']   = monster.select('td[5]/a/span/text()').extract()
      item['secondary_type'] = monster.select('td[6]/a/span/text()').extract()
      items.append(item)
    return items
