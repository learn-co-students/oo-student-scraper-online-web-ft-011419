require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.find_social_link(page, social_string)
    if page.css("div.social-icon-container a").find {|social_link| social_link.attribute("href").value.include?(social_string)}
      page.css("div.social-icon-container a").find {|social_link| social_link.attribute("href").value.include?(social_string)}.attribute("href").value
    else
      'none'
    end
  end
  def self.find_blog(page, regex)
    if page.css("div.social-icon-container a").find {|social_link| social_link.attribute("href").value.match(regex)}
      page.css("div.social-icon-container a").find {|social_link| social_link.attribute("href").value.match(regex)}.attribute("href").value
    else
      'none'
    end
  end

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index = Nokogiri::HTML(html)
    scraped_students = []
    index.css("div.student-card").each do |profile|
      scraped_students << {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    profile_name = profile_page.css('h1.profile-name').text.downcase.split(' ')
    blog_regex = /#{profile_name[0]}.?#{profile_name[1]}(.io|.com)/
    scraped_student = {
      :twitter => find_social_link(profile_page, 'twitter'),
      :linkedin => find_social_link(profile_page, 'linkedin'),
      :github => find_social_link(profile_page, 'github'),
      :blog => find_blog(profile_page, blog_regex),
      :profile_quote => profile_page.css("div.profile-quote").text,
      :bio => profile_page.css("div.description-holder p").text
    }
    scraped_student.each do |attribute, value|
      if value == 'none'
        scraped_student.delete(attribute)
      end
    end
    scraped_student
  end

end
