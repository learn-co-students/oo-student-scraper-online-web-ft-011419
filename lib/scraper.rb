require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    data=[]
  file=doc.css("div.student-card").each do |element|
    data << a={:profile_url=>element.css("a").attribute("href").value,
    :name=>element.css(".student-name").text,
    :location=>element.css(".student-location").text}
end
data
  end

  def self.scrape_profile_page(profile_url)
doc = Nokogiri::HTML(open(profile_url))
file={}
data=doc.css(".social-icon-container a")
data.collect do|tag|
t=tag.attribute("href").value


file[:linkedin]="t" unless t== nil
  file [:github]="t" unless t== nil
file  [:twitter]="t"  unless t== nil
#:profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#     :bio=> "I'm a school"


end
end

end
