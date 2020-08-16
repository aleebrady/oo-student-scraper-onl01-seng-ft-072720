require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    array = [] # create empty array 
    doc = Nokogiri::HTML(open(index_url)) # uses nokogiri to parse he html, open-uri opens the url
    
    doc.css(".student-card").each do |student| # iterates through each student gets data
      array << { # shovels data into empty array of hashes
        :name => student.css("h4.student-name").text, #uses css to get the specific data 
        :location => student.css("p.student-location").text,
        :profile_url => student.children[1].attributes["href"].value
      }
    end
      array # returns array of hashes with student data requested 
  end

  def self.scrape_profile_page(profile_url)
    
    hash = {}
    page = Nokogiri::HTML(open(profile_url))
    
    links = page.css(".social-icon-container").css('a').collect {|e| e.attributes["href"].value}

    links.each do |link|

      hash[:twitter] = link if link.include?("twitter") # checks for twitter
      hash[:linkedin] = link if link.include?("linkedin") #checks for linkedin
      hash[:github] = link if link.include?("github") # checks for github

    end

    hash[:blog] = links[3] if links[3] != nil # returns blog in hash 
    hash[:profile_quote] = page.css(".profile-quote")[0].text 
    hash[:bio] = page.css(".description-holder").css('p')[0].text
    hash
  end
  
  

end

