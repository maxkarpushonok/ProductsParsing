# Test ruby
require 'curb'
require 'nokogiri'
require 'csv'

#Entry data
# puts 'Enter category URL:'
# URL = gets.chomp
# puts 'Enter csv file name:'
# file = gets.chomp
URL = 'https://www.petsonic.com/snacks-higiene-dental-para-perros/'
FILE = 'file'

#Parsing category page
puts 'Start open category page...'
html = Curl.get(URL)

#TODO recursion def
puts 'Start parsing category page...'
products_url = []
doc = Nokogiri::HTML(html.body)
doc.css('a.product_img_link').each do |a|
  products_url.push(a['href'])
end
#TODO debug
# puts products_url

#Parsing pages
puts 'Start parsing pages...'
products = []
products_url.each do |url|
  html = Curl.get(url)
  doc = Nokogiri::HTML(html.body)
  name = doc.xpath('//h1').text
  image = doc.xpath("//img[@id='bigpic']/@src")
  prices = doc.xpath("//label[contains(@class, 'label_comb_price')]").each do |l|
    puts l.xpath("//span[@class = 'price_comb']").text.split('/').first()
    # name = l.xpath("//span[contains(@class, 'radio_label')]").text
    # price = l.xpath("//span[contains(@class, 'price_comb')]").text
    #TODO debug
    # puts name + ' = ' + price
  end
end
puts 'End...'
