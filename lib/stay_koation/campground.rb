require 'pry'

class Campground

    attr_accessor :name, :campgrounds

    @@all = []
    
    def initialize(name)
        @name = name
        @campgrounds = []
        @@all << self
    end

    def self.scrape_koa_campgrounds
        doc = Nokogiri::HTML(open("https://koa.com/states-provinces/alabama/"))
        campgrounds = doc.search("div.media-heading").text
        campgrounds_array = campgrounds.split(" KOA")
         #binding.pry
         puts campgrounds_array
    end
end