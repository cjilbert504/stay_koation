require 'pry'

class Campground

    attr_accessor :name, :amenities, :state_pick, :campgrounds_array, :view_selection, :amenities_url
    
 

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

    def self.campground_menu
        counter = 1
        puts
        self.all.each do |x| 
            puts "#{counter}. #{x.name}"
            counter += 1
        end
    end

    def self.view_amenities_selection 
        puts "Please select the number of the campground whose amenities you would like to view:"
        @view_selection = gets.strip.to_i
    end

    def self.campground_name_normalize
        name = Campground.all[@view_selection-1].name
        name.gsub!(" KOA", "")
        url_name = name.split(" / ")
        @amenities_url = url_name[0].downcase
    end

    def self.amenities_scrape
        doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
        amenities = doc.search("li.col-sm-6.col-xl-4").text
        amenities_array = amenities.split
        puts
        puts amenities_array
        #Need to figure out a better way to parse this data
    end


    
end