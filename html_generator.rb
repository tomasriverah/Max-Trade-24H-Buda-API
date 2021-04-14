
#### Esta funcion genera el html 

def html_generator(market_max)
    html = File.new("out.html", "w")
    html.puts("
<!DOCTYPE html>
<html>
    <style>
    table, th, td {
        border: 1px solid black;
      }
    </style>
    <body>
        
        <table>
            <tr>
                <th>Market</th>
                <th>Transaction Amount</th>
            </tr>"
        )
    
    market_max.each do |key, value|
        html.puts("<tr>
                    <td>" + key.to_s + "</td>
                    <td>" + value.to_s + "</td>
                   </tr>")
    end
            
            
    html.puts("</table>

        </body>
    </html>")     
    

    puts "HTML generated"
end

