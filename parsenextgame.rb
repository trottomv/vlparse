require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'

class Nextgame
  def url
    "http://web.legabasket.it"
  end

  def clubpage
    club = "http://web.legabasket.it/team/tbd.phtml?club=PS"
    Nokogiri::HTML(open("#{club}")).css("div.menu a").map { |link| link['href']}[2]
  end

  def calendarteampage
    Nokogiri::HTML(open("#{url}#{clubpage}")) #open team url
  end

  def nextgameurl
    calendarteampage.css('a').select{|a|a.text =~ /0-0/}.map { |link| link['href'] }.first #('a:contains("0-0")')
    # Nokogiri::HTML(open("#{url}#{calendarteampage}/")).at('a:contains("0-0")').map { |link| link['href'] }
  end

  def parse
    gameurl = "#{url}#{nextgameurl}"
    Nokogiri::HTML(open("#{gameurl}")) #open team url
  end

  def gamestand
      parse.css(".game-result-container")
  end

  def dategame
    parse.css(".page-title").text.split(', ')[0].gsub(" - ", "").lstrip[0..-6]
  end

  def hourgame
    parse.css(".page-title").text.split(', ')[0].gsub(" - ", "").lstrip[-5..15]
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

  def message
    if nextgameurl.empty?
      message = "Nessuna partita di campionato a breve"
      message
    else
      message =
  "#{dategame} #{hourgame}
  #{round}
  #{team1.text} VS #{team2.text}"
      message
    end
  end

end

puts Nextgame.new.message
