require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    inspect_page = Nokogiri::HTML(open(index_url))
    students = []
    scrape_page = inspect_page.css(".student-card")
    scrape_page.each do |student|
      students << {
      :name => student.css(".student-name").text, 
      :location => student.css(".student-location").text, 
      :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    inspect_page = Nokogiri::HTML(open(profile_url))
    
    student_hash = {}
    student_hash[:bio] = inspect_page.css("div.description-holder p").text
    student_hash[:profile_quote] = inspect_page.css("div.profile-quote").text
    
    inspect_page.css(".social-icon-container a").each do |icon|
      link = icon.attr("href")
      if link.include?("twitter")
        student_hash[:twitter] = link
        elsif link.include?("linkedin")
        student_hash[:linkedin] = link
        elsif link.include?("github")
        student_hash[:github] = link
        else 
          student_hash[:blog] = link
        end
      end
      student_hash
    end
  end