require 'pry'

class Campground

    attr_accessor :name, :amenities, :state_pick, :campgrounds_array
    
 

    @@all = []
    
    def initialize(name)
        @name = name
        @amenities = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.state_select(state)
        @state_pick = state
    end

    def self.scrape_koa_campgrounds
        doc = Nokogiri::HTML(open("#{@state_pick}"))
        campgrounds = doc.search("div.media-heading").text
        @campgrounds_array = campgrounds.split(" KOA")
    end

    def self.new_from_scrape
        @campgrounds_array.each {|x| x = self.new(x)}
    end

end