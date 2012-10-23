import w3lib

from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.http import Request, FormRequest
from scrapy.selector import HtmlXPathSelector
from scrapy.spider import BaseSpider

from pokedex.items import PokemonListing

class PokemonSpider(CrawlSpider):
  name = "pokemon"
  allowed_domains = ["bulbapedia.bulbagarden.net"]
  start_urls = [
      "http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number",
      #"file:///Users/dk/workspace/current/Pokedex/Scripts/scraper/html/pokedex.html",
  ]

  POKEMON_PATTERN = r'wiki/[^()/]+\(Pok%C3%A9mon\)'
  rules = (
      ## Extract links matching 'category.php' (but not matching 'subsection.php')
      ## and follow links from them (since no callback means follow=True by default).
      #Rule(SgmlLinkExtractor(allow=('category\.php', ), deny=('subsection\.php', ))),

      # Extract links matching 'item.php' and parse them with the spider's method parse_item
      #Rule(SgmlLinkExtractor(allow=('(Pokemon)', )), callback='parse_detail_page'),
      Rule(SgmlLinkExtractor(allow=(POKEMON_PATTERN, )), callback='parse_detail_page'),
  )

  def parse_pokemon_list(self, response):
    hxs = HtmlXPathSelector(response)

    pokemon_list_query = "//table[3]/tr"

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
  
  def parse_traverse(self, response):
    hxs = HtmlXPathSelector(response)

    pokemon_list_query = "//table[3]/tr"
    monsters = hxs.select(pokemon_list_query)[1:]

    items = []
    for monster in monsters:
      detail_page_relative_link = monster.select('td[5]/a/@href').extract()[0]
      detail_page_link = "http://bulbapedia.bulbagarden.net/%s" % detail_page_relative_link

      items += Request(url=detail_page_link,
             callback=self.parse_detail_page)
    return items
  
  def parse_detail_page(self, response):
    self.log('Hi, this is a Pokemon detail page! %s' % response.url)

    hxs = HtmlXPathSelector(response)
    
    item = PokemonListing()
    # will this work?
    bio = hxs.select("id('mw-content-text')/p[4]").extract()[0]
    item['biography'] = w3lib.html.replace_tags(bio)
    #$x("id('mw-content-text')/p[4]/text()") # without HTML values

    pokemon_table_query = "id('mw-content-text')/table[3]"
    table = hxs.select(pokemon_table_query)[0]

    item['number'] = table.select("tr[1]/td/table/tr/td/table/tr/td/big/big/span/b/a/span/text()").extract()
    item['name'] = table.select("tr[1]/td/table/tr/td/table/tr/td/big/big/b/text()").extract()

    item['large_icon'] = table.select("tr[2]/td/table/tr/td/a/img/@src").extract()

    item['primary_type'] = table.select("tr[3]/td/table/tr/td/table/tr/td/table/tr[1]/td[1]/a/span/b[1]/text()").extract()[0]
    item['secondary_type'] = table.select("tr[3]/td/table/tr/td/table/tr/td/table/tr[1]/td[2]/a/span/b[1]/text()").extract()[0]

    return item
