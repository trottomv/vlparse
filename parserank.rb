require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'

class Rank
  def url
    "http://web.legabasket.it"
  end

  def parse
    rank = "http://web.legabasket.it/stand/complete.phtml"
    Nokogiri::HTML(open("#{rank}"))
  end

  def rankparse
    parse.css('table').search('tr')[3..25].map.each do | cell |
    {
      position: cell.search('th, td')[0].text,
      team: cell.search('th, td')[1].text,
      point: cell.search('th, td')[2].text
    } #.each do | rankteam |
    end
  end

  def message
      rankparse.map do | rank |
        message = " #{rank[:position].chomp('.')} [#{rank[:point]}pt] #{rank[:team]}"
        message
      end
  end

end

puts Rank.new.message
