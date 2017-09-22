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
puts "#{team1.text} VS #{team2.text} #{gameresult.text.strip} "
puts "Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
