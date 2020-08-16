require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    array = [] # create empty array 
    doc = Nokogiri::HTML(open(index_url)) 
    
    doc.css(".student-card").each do |student|
      array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.children[1].attributes["href"].value
      }
    end
      array
  end

  def self.scrape_profile_page(profile_url)
    
    hash = {}
    page = Nokogiri::HTML(open(profile_url))
    
    links = page.css(".social-icon-container").css('a').collect {|e| e.attributes["href"].value}

    links.detect do |e|

      hash[:twitter] = e if e.include?("twitter")
      hash[:linkedin] = e if e.include?("linkedin")
      hash[:github] = e if e.include?("github")

    end

    hash[:blog] = links[3] if links[3] != nil
    hash[:profile_quote] = page.css(".profile-quote")[0].text
    hash[:bio] = page.css(".description-holder").css('p')[0].text
    hash
  end
  
  

end

