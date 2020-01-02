require 'pry'

class Campground

    attr_accessor :name, :campgrounds, :state_pick
 

    @@all = []
    
    def initialize(name)
        @name = name
        @campgrounds = []
        @@all << self
    end

    def self.scrape_koa_campgrounds
        doc = Nokogiri::HTML(open("#{@state_pick}"))
        campgrounds = doc.search("div.media-heading").text
        campgrounds_array = campgrounds.split(" KOA")
        puts
        puts campgrounds_array
        puts
    end

    def self.state_select(state)
        @state_pick = state
    end

end