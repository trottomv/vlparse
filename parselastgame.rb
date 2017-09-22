require 'rubygems'
require 'nokogiri'
require 'open-uri'

def url
  url = "http://web.legabasket.it"
end

def teampage
  team = "http://web.legabasket.it/team/1296/consultinvest_pesaro"
  page = Nokogiri::HTML(open("#{team}"))
end

def lastgameurl
  lastgameurl = teampage.css("a.matchResult").map { |link| link['href'] }
end

def parse
  gameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  parse = Nokogiri::HTML(open("#{gameurl}"))
end

def gamestand
  parse.css(".game-result-container")
end

def dategame
  parse.css(".page-title")
end

def stadium
  parse.css(".page-title")
end

def round
  parse
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
# end

puts round.text.lstrip.chop
puts "#{team1.text} VS #{team2.text}"
puts gameresult.text.lstrip.chop
puts "Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
