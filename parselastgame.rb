
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'

def url
  url = "http://web.legabasket.it"
end

def page
  team = "http://web.legabasket.it/team/1296/consultinvest_pesaro"
  page = Nokogiri::HTML(open("#{team}"))
end

def lastgameurl
  # gameurl = page.xpath('//a[contains(text(""), "matchResult")]').map { |link| link['href'] }.each do | gameurl |
  # gameurl = page.css(".other-team-information").each do | gameurl |
  lastgameurl = page.css("a.matchResult").map { |link| link['href'] }
end

# puts lastgameurl.first.split('/')[2]

def lastgamestand
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".game-result-container").each do | gameresult |
    puts gameresult.text
  end
end

# puts lastgamestand

def dategame
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".page-title").each do | title |
    puts title.text.split(', ')[0].gsub(" - ", "").to_str
  end
end

# puts dategame

def stadium
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".page-title").each do | title |
    puts title.text.split(', ')[1].split(': ')[1].gsub(" - ", "").to_str
  end
end

# puts stadium

def round
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".titleBig").each do | title |
    puts title.text
  end
end

# puts round


def team1
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".team-name1").each do | title |
    puts title.text
  end
end

# puts team1


def team2
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".team-name2").each do | title |
    puts title.text
  end
end

# puts team2

def gameresult
  completegameurl = "#{url}/game/#{lastgameurl.first.split('/')[2]}/"
  page = Nokogiri::HTML(open("#{completegameurl}"))
  lastgamestand = page.css(".game-total-result").each do | result |
    puts result.text
  end
end

# puts gameresult

def condition
  Date.parse('dategame.text') < Date.today.strftime('%d/%m/%Y%H:%M') #"07/05/201720:45"
end

# puts condition

puts "#{round}#{dategame}#{stadium}#{team1}#{team2}#{gameresult} Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
