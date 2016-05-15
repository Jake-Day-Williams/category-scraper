require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'

page = HTTParty.get('http://saltlakecity.craigslist.org/search/sof')

parse_page = Nokogiri::HTML(page)

jobs_array = []

parse_page.css('.content').css('.row').css('.hdrlnk').map do |a|
  post_name = a.text
  jobs_array.push(post_name)
end

CSV.open('positions.csv', 'w') do |csv|
  csv << jobs_array
end