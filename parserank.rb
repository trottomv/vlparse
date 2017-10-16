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
      position: cell.search('th, td')[0..1].text,
      point: cell.search('th, td')[2].text
    } #.each do | rankteam |
    end
  end

  def rankteam
    parse.css('table').search('tr')[3..25].map { | cell |
      cell.search('th, td')[1].text.strip
    } #.each do | rankteam |
    # end
  end

  def rankpoint
    parse.css('table').search('tr')[3..25].map { | cell |
      cell.search('th, td')[2].text.strip
    } #.each do | rankpoint |
    # end
  end

  def message
      rankparse.each_with_index do | rank, index |
          # message = rank[:position]
      # rank.map do |message|
          message = "#{rank[:position]} #{rank[:point]}"
          message
          # return message
          # rank[:point]
          # return message
        # end
      end
  end

end

# puts "#{Rank.new.rankposition} #{Rank.new.rankteam} #{Rank.new.rankpoint}"
puts Rank.new.message

# Rank.new.rankposition.map do | rankposition |
#   puts "#{Rank.new.rankposition[3..25]} #{Rank.new.rankteam[3..25]} #{Rank.new.rankpoint[3..25]}"
# end
