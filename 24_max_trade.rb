require 'rest-client'
require 'json'
require 'rails'

#### Esta función encuentra la transacción más alta en las ultimas 24h para un mercado y retorna su max

def largest_24h_trade(market_id)
    
    break_condition = false
    last_timestamp = false

    #### Obtenemos el tiempo unix de hace 24h en milisegundos para que concuerde con el entregado por la API

    yesterday_time = (DateTime.now - 24.hours).strftime('%Q').to_i
    
    current_max = 0

    #### Realizamos un while loop para llamar intervalos de transacciones hacia el pasado 
    #### uno por uno hasta cumplir las 24h atrás

    while !break_condition do
        
        #### If para diferenciar primera llamada sin timestamp y el resto que si incluye

        if (!last_timestamp)
            max, last_timestamp = trade_request(market_id)
        else
            max, last_timestamp = trade_request(market_id, '&timestamp=' + last_timestamp)
        end

        #### Si el maximo retornado es mayor al maximo previo se actualiza

        if max > current_max
            current_max = max
        end

        #### Si la hora de la ultima transacción es mayor al tiempo corte se hace verdadera 
        #### la condición de parada y se sale del loop

        if yesterday_time > last_timestamp.to_i
            puts "we stopping"
            break_condition = true
        end

    end
    
    return current_max

end 

#### Esta función retorna el max transado en el intervalo entregado por la API y
#### el last timestamp de este intervalo

def trade_request(market_id, timestamp_string = "")
    max = 0
    yesterday_time = (DateTime.now - 24.hours).strftime('%Q').to_i

    #### Se realiza el request con el id de mercado y el timestamp más reciente a buscar

    request = RestClient.get('https://www.buda.com/api/v2/markets/' + market_id +'/trades?limit=100' + 
        timestamp_string , headers={})

    #### Se parsea las respuestras
    
    request_hash = JSON.parse(request)
    trades_hash = request_hash["trades"]
    entries_array = trades_hash["entries"]
    last_timestamp = trades_hash["last_timestamp"]

    #### Iteramos sobre cada una de las transacciones, si el monto es mayor al max actual y su tiempo es mayor
    #### al tiempo corte de 24h se actualiza el max

    entries_array.each do |timestamp, amount, price, direction|
       
        if amount.to_f > max && timestamp.to_i > yesterday_time
            max = amount.to_f
        end
    end
    
    
    return max, last_timestamp
end



