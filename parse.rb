
require 'rubygems'
require 'nokogiri'
require 'open-uri'


def url
  url = "http://web.legabasket.it"
end

def page
  page = Nokogiri::HTML(open("http://web.legabasket.it/team/1314/vl_pesaro/schedule"))
end

def gameurl
#puts page.class   # => Nokogiri::HTML::Document
# href = page.search('a').text_includes("Consultinvest Pesaro")
gameurl = page.xpath('//a[contains(text(), "-")]').map { |link| link['href'] }
gameurl.each do |gameurl|
  completegameurl = "#{url}#{gameurl}"
  puts completegameurl
end
end

# gameurl.each do |gameurl|
#   puts gameurl
# end

def gamedatetime
  datetime = page.xpath('//a[contains(text(), ":")]')
end

gamedatetime.each do |gamedatetime|
  puts gamedatetime.text
end


def gameresult
  # page = Nokogiri::HTML(open("http://web.legabasket.it/team/1314/vl_pesaro/schedule"))
  # href = page.xpath('//a[contains(text(), "-")]').map { |link| link['href'] }
  gameurl.each do |gameurl|
    gamestand = Nokogiri::HTML(open("#{url}#{gameurl}"))
    gamestand.css(".game-result-container,.page-title").each do |gamestand|
        puts gamestand.content
      end
  end
end

gameresult.each do |gameresult|
  puts gameresult
end


# doc.search('p').text_includes('bar')

# puts page.grep(/href/)
# puts page.grep("#{Time.now.strftime(%d/%m/%Y)}")
#{Time.now.strftime("%d/%m/%Y")}
