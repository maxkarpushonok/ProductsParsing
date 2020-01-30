# Test ruby
require 'curb'
require 'nokogiri'
require 'csv'

#Entry data
# puts 'Enter category URL:'
# url = gets.chomp
# puts 'Enter csv file name:'
# file = gets.chomp
url = 'https://www.petsonic.com/snacks-higiene-dental-para-perros/'
file = 'file'

#Parsing category page
puts 'Start open category page...'
html = Curl.get(url)

#TODO recursion def
puts 'Start parsing category page...'
products_url = []
doc = Nokogiri::HTML(html.body)
doc.css('a.product_img_link').each do |a|
  products_url.push(a['href'])
end
#TODO debug
# puts products_url


