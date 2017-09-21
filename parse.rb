
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'

def url
  url = "http://web.legabasket.it"
end

def page
  page = Nokogiri::HTML(open("http://web.legabasket.it/team/1314/vl_pesaro/schedule"))
end

def gameurl
  gameurl = page.xpath('//a[contains(text(), "-")]').map { |link| link['href'] }
  # gameurl.each do |gameurl|
  #   completegameurl = "#{url}#{gameurl}"
  #   puts completegameurl
  # end
end

gameurl.each do |gameurl|
  puts "#{url}#{gameurl}"
end

def gamedatetime
  datetime = page.xpath('//a[contains(text(), ":")]')
end

gamedatetime.each do | gamedatetime |
  puts gamedatetime.text
end

gamedatetime.each do | d |
  d = gamedatetime.text
  if d < "#{Time.now.strftime('%d/%m/%Y%H:%M')}"
    puts d
  end
end


def gameresult
  gameurl.each do | gameurl |
    r = Nokogiri::HTML(open("#{url}#{gameurl}"))
    r.css(".game-result-container,.page-title").each do |gamestand|
        puts gamestand.content
    end
  end
end

gameresult.each do |gameresult|
  puts gameresult
end
