require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

     students_hash = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      hash = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").text
      }
      students_hash << hash
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    students_hash = {}
    doc.css("div.social-icon-container a").each do |student|
            url = student.attribute("href").text
            students_hash[:twitter] = url if url.include?("twitter")
            students_hash[:linkedin] = url if url.include?("linkedin")
            students_hash[:github] = url if url.include?("github")
            students_hash[:blog] = url if student.css("img").attribute("src").text.include?("rss")
        end
            students_hash[:profile_quote] = doc.css("div.profile-quote").text
            students_hash[:bio] = doc.css("div.description-holder p").text
        students_hash
      end
    end
