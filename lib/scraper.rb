require 'open-uri'
require 'pry'

class Scraper

     def self.scrape_index_page(index_url)
   index_data = []
    doc = Nokogiri::HTML(open(index_url))
     students = doc.css("div .student-card")

     students.each do |student|
     
       name = student.css("a .card-text-container .student-name").text
       location = student.css("a .card-text-container .student-location").text
       profile_url = student.css("a").attribute("href").text
       index_data << {:name => name, :location => location, :profile_url => profile_url}
       #index_data << {:name => name, {:location => location, :profile_url => profile_url}}
     end
     index_data
  end

 def self.scrape_profile_page(profile_url)
    profile_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".social-icon-container a")

    social.each do |social_link|
      if social_link.attribute("href").text.include?("twitter.com")
           profile_hash[:twitter] = social_link.attribute("href").text
      elsif social_link.attribute("href").text.include?("github.com")
        profile_hash[:github] = social_link.attribute("href").text
      elsif social_link.attribute("href").text.include?("linkedin.com")
        profile_hash[:linkedin] = social_link.attribute("href").text
      else
        profile_hash[:blog] = social_link.attribute("href").text
      end

    end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    profile_hash[:bio]= doc.css(".bio-content .description-holder").text.strip

     profile_hash
  end

end

