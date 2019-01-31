require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'

class Scraper

attr_accessor :students, :attributes

 def self.scrape_index_page(index_url)
   doc = Nokogiri::HTML(open(index_url))
   students = []
   doc.css(".student-card").each do |student|
     name = student.css(".student-name").text
     location = student.css(".student-location").text
     profile_url = student.css("a").attribute("href").value
     student_profile = {:name => name,
               :location => location,
               :profile_url => profile_url}
     students << student_profile
     end
   students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    attributes = {}
    container = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          attributes[:twitter] = link
        elsif link.include?("linkedin")
          attributes[:linkedin] = link
        elsif link.include?("github")
          attributes[:github] = link
        elsif link.include?(".com")
          attributes[:blog] = link
        end
      end
  attributes[:profile_quote] = doc.css("div.profile-quote").text
  attributes[:bio] = doc.css("div.bio-content div.description-holder").text.strip
  attributes
end

end
