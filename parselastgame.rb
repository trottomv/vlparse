require 'rubygems'
require 'nokogiri'
require 'open-uri'

def url
  "http://web.legabasket.it"
end

def teampage
  team = "http://web.legabasket.it/team/1296/consultinvest_pesaro" #2016
  # team = "http://web.legabasket.it/team/1314/vl_pesaro" #2017
  Nokogiri::HTML(open("#{team}"))
end

def lastgameurl
  teampage.css("a.matchResult").map { |link| link['href'] }
end

def parse
  gameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  Nokogiri::HTML(open("#{gameurl}"))
end

def gamestand
  parse.css(".game-result-container")
end

def dategame
  parse.css(".page-title")
  #title.text.split(', ')[0].gsub(" - ", "").to_str
end

def stadium
  parse.css(".page-title")
  # title.text.split(', ')[1].split(': ')[1].gsub(" - ", "").to_str
end

def round
  parse.css(".titleBig")
end

def team1
  parse.css(".team-name1")
end

def team2
  parse.css(".team-name2")
end

def gameresult
  parse.css(".game-total-result")
end

def teamselect
  if team1.text.include? "Pesaro"
    ('[id="fullstat1"] > tbody > tr')
  elsif team2.text.include? "Pesaro"
    ('[id="fullstat2"] > tbody > tr')
  end
end

def playername
  parse.css("#{teamselect}").search('tr').map { | cell |
    cell.search('th, td')[2].text.strip
  }.each do | playername |
  end
end

def playerscore
  parse.css("#{teamselect}").search('tr').map { | cell |
    cell.search('th, td')[3].text.strip.to_i
  }.each do | playerscore |
  end
end




# def playername
#   parse.css("#{teamselect}").each do | tr |
#           puts tr.css('td').map{ |td|
#             td.text.gsub(/[$,](?=\d)/, '').gsub(/\302\240|\s/, ' ').strip
#           }[2]
#
#         # puts playername
#   end
# end


# def teamscoresheet
#   if team1.text.include? "Pesaro"
#     parse.css('[id="fullstat1"]')
#   elsif team2.text.include? "Pesaro"
#       # parse.css('[id="fullstat2"]')
#       parse.css('[id="fullstat2"] > tbody > tr').each do | tr |
#           playername = tr.css('td').map{ |td|
#             td.text.gsub(/[$,](?=\d)/, '').gsub(/\302\240|\s/, ' ').strip
#           }.join(" | ").split(" | ")[2]
#           playerscore = tr.css('td').map{ |td|
#             td.text.gsub(/[$,](?=\d)/, '').gsub(/\302\240|\s/, ' ').strip
#           }.join(" | ").split(" | ")[3].to_i
#           plusminus = tr.css('td').map{ |td|
#             td.text.gsub(/[$,](?=\d)/, '').gsub(/\302\240|\s/, ' ').strip
#           }.join(" | ").split(" | ")[27].to_i
#           # if playername.include? "Hazell"
#           # if playerscore.max
#             puts playername
#             puts playerscore
#             # puts plusminus
#           # end
#           # puts plusminus
#         # Nokogiri::HTML("#{player}").css("td").each do | playerstand |
#         #   puts playerstand.text
#         # end
#       end
#   end
# end

# def condition
#   Date.parse('dategame.text') < Date.today.strftime('%d/%m/%Y%H:%M') #"07/05/201720:45"

  # if (01/01/2016..01/01/2017) === dategame
  #   puts true
  # else
  #   puts false
  # end

# end

puts "#{dategame.text.split(', ')[0].gsub(" - ", "").lstrip[0..-6]} #{round.text.strip}"
# puts stadium.text.split(', ')[1].split(': ')[1].gsub(" - ", "").lstrip.chop
puts "#{team1.text} VS #{team2.text} #{gameresult.text.strip}"
puts "Topscorer: #{playername[playerscore.index(playerscore.sort[-2])]} #{playerscore.sort[-2]}pt"
puts "Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
# puts teamscoresheet
# puts gameresult.text.strip
# puts "#{playername} #{playerscore}"
# puts playerscore.sort[-2] #topscore
# puts playername["#{playerscore.index(playerscore.sort[-2])}"]
# puts playername[playerscore.index(playerscore.sort[-2])] #topscorername
