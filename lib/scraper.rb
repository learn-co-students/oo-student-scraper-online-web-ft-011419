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
    profile_hash = {}
    profile_scrape = doc.css(".social-icon-container")

    profile_scrape.css("a").each do |social|
      profile_array << social.attribute("href").value
    end

    profile_array.each do |social|
      if social.include?("twitter")
        profile_hash[:twitter] = social
      elsif social.include?("linkedin")
        profile_hash[:linkedin] = social
      elsif social.include?("github")
        profile_hash[:github] = social
      elsif social.end_with?(".com/")
        profile_hash[:blog] = social
      end
    end

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text
    profile_hash
  end

end
