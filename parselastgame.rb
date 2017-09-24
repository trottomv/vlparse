require 'rubygems'
require 'nokogiri'
require 'open-uri'


class Scoresheet
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
  end

  # def stadium
  #   parse.css(".page-title")
  #   # title.text.split(', ')[1].split(': ')[1].gsub(" - ", "").to_str
  # end

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

  def message
    message = "#{dategame.text.split(', ')[0].gsub(" - ", "").lstrip[0..-6]} #{round.text.strip}
#{team1.text} VS #{team2.text} #{gameresult.text.strip}
Topscorer Pesaro: #{playername[playerscore.index(playerscore.sort[-2])].split(" ").reverse.join(" ")} #{playerscore.sort[-2]}pt
Tabellino: #{url}/game/#{lastgameurl.first.split('/')[2]}/"
    message
  end
end

puts Scoresheet.new.message
