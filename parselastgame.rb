require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'

class Scoresheet
  def url
    "http://web.legabasket.it"
  end

  def clubpage
    club = "http://web.legabasket.it/team/tbd.phtml?club=PS"
    Nokogiri::HTML(open("#{club}")).css("div.menu a").map { |link| link['href']}[0]
  end

  def teampage
    # team = "http://web.legabasket.it/team/1296/consultinvest_pesaro" #2016
    # team = "http://web.legabasket.it/team/1314/vl_pesaro" #2017
    Nokogiri::HTML(open("#{url}#{clubpage}")) #open team url
    # Nokogiri::HTML(open("#{team}"))
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
    parse.css(".page-title").text.split(', ')[0].gsub(" - ", "").lstrip[0..-6]
  end

  # def stadium
  #   parse.css(".page-title")
  #   # title.text.split(', ')[1].split(': ')[1].gsub(" - ", "").to_str
  # end

  def round
    parse.css(".titleBig").text.strip
  end

  def team1
    parse.css(".team-name1")
  end

  def team2
    parse.css(".team-name2")
  end

  def gameresult
    parse.css(".game-total-result").text.strip
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

  def message
    if lastgameurl.empty?
      message = "Nessuna partita di campionato giocata recentemente"
      message
    else
      message =
"#{dategame} #{round}
#{team1.text} VS #{team2.text} #{gameresult}
Topscorer Pesaro: #{playername[playerscore.index(playerscore.sort[-2])].split(" ").reverse.join(" ")} #{playerscore.sort[-2]}pt
Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
      message
    end
  end
end

puts Scoresheet.new.message
# puts Scoresheet.new.lastgameurl.first.split('/')[2]
# puts Scoresheet.new.dategame
# diffdate = Time.now.to_i - DateTime.new(Scoresheet.new.dategame.split('/')[2].to_i,Scoresheet.new.dategame.split('/')[1].to_i,Scoresheet.new.dategame.split('/')[0].to_i).strftime('%s').to_i
# puts diffdate/60/60/24 #diffdate in n. of day
# # puts Scoresheet.new.lastgameurl.empty?
# if Scoresheet.new.lastgameurl.empty?
#   puts "nessuna partita"
# else
#   puts Scoresheet.new.message
#   # puts Scoresheet.new.clubpage
# end
