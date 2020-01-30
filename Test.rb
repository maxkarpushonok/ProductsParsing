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

#TODO pages with one price
#Parsing pages
puts 'Start parsing pages...'
products = []
products_url.each do |url|
  html = Curl.get(url)
  doc = Nokogiri::HTML(html.body)
  name = doc.xpath('//h1').text
  image_url = doc.xpath("//img[@id='bigpic']/@src").text
  doc.xpath("//label[contains(@class, 'label_comb_price')]").each do |l|
    type = l.css('.radio_label').text
    price = l.css('.price_comb').text.split('/').first
    products.push('name'=> name + ' - ' + type, 'price' => price, 'image_url' => image_url)
  end
end

#TODO debug
# puts products

#Save to .csv
puts 'Start saving to ' + FILE + '.csv file...'
CSV.open(FILE + '.csv', 'w') do |csv|
  products.each { |p|
    csv << [p['name'], p['price'], p['image_url']]
  }
end

puts 'End.'
