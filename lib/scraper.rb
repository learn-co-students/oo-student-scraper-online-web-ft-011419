require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students_array = []

    student_elements = doc.css('.student-card')
    student_elements.each do |student_element|
      student_hash = {}
      student_hash[:name] = student_element.css('.student-name').text
      student_hash[:location] = student_element.css('.student-location').text
      student_hash[:profile_url] = student_element.css('a').attr('href').text
      students_array << student_hash
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile_hash = {}

    profile_hash[:bio] = doc.css("div.description-holder p").text
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text

    doc.css(".social-icon-container a").each do |icon|
      link = icon.attr("href")
       if link.include?("twitter")
         profile_hash[:twitter] = link
       elsif link.include?("linkedin")
         profile_hash[:linkedin] = link
       elsif link.include?("github")
         profile_hash[:github] = link
      else
        profile_hash[:blog] = link
      end
    end

    profile_hash
  end
end
