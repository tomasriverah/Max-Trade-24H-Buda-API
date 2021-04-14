##### Script para obtener la mayor transacción de cada mercado disponible en la API de buda.com
##### Realizado por Tomás Rivera H.

require 'rest-client'
require 'json'
require './24_max_trade'
require './html_generator'

puts "Ruby script goes brrrrrrrr"

##### Se obtienen los mercados y se parsea la información

markets_json = RestClient.get('https://www.buda.com/api/v2/markets', headers={})

markets_hash = JSON.parse(markets_json)

#### Se crea un array con los ids de los mercados

market_ids = []

markets_hash["markets"].each do |market_hash|
    market_ids << market_hash["id"]
    end



market_maxs = {}

#### Iteramos sobre cada mercado para encontrar la respectiva transacción más alta

market_ids.each do |id|
    puts "Fetching data from market: " + id
    puts "Please wait, this could take a second"
    max = largest_24h_trade(id)
    puts "Max: " + max.to_s
    puts "---------------------------------"
    market_maxs[id] = max

end

#### Se genera el html con la info de los mercados

html_generator(market_maxs)
