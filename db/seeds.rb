require 'open-uri'  
require 'json'

Currency.delete_all

file = open("https://gist.githubusercontent.com/Fluidbyte/2973986/raw/b0d1722b04b0a737aade2ce6e055263625a0b435/Common-Currency.json").read   
data = []
items = JSON.parse(file)
currencies = JSON.parse(file).keys


currencies.each do |currency|
	item = items[currency]
  object = {
		"symbol": item["symbol"],
		"name": 	item["name"],
		"code": 	item["code"]
  }
  data << object
end

Currency.create!(data)

