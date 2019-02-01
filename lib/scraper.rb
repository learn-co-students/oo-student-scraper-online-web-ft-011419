require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    index_scrape = doc.css(".student-card")
    index_scrape.each do |student|
      student_array << {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => student.css("a").attribute("href").value}
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_array = []
    profile_scrape = doc.css(".social-icon-container")
    profile_scrape.each do |social|
      binding.pry
    end
  end

end
