require 'pry'

class Campground

    attr_accessor :name, :amenities, :state_pick, :campgrounds_array, :amenities_url, :state
    
 

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
        doc = Nokogiri::HTML(open("#{@state_pick.url}"))
        campgrounds = doc.search("div.media-heading").text
        campgrounds_array = campgrounds.split(" KOA")
        Campground.new_from_scrape(campgrounds_array)
    end

    def self.new_from_scrape(camps)
        camps.each do |x| 
            @state_pick.campgrounds << self.new(x)
        end
    end

    def self.campground_menu
        counter = 1
        puts
        self.all.each do |x| 
            puts "#{counter}. #{x.name}"
            counter += 1
        end
    end

    def get_amenities(camp)
        campground = camp
        campground.campground_name_normalize
    end

    def campground_name_normalize
        @name.gsub!(" KOA", "")
        url_name = @name.split(" / ")
        @amenities_url = url_name[0].downcase.gsub(" ", "-")
        amenities_scrape
    end

    def amenities_scrape
        doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
        amenities = doc.search("ul.gray-bullet-list.row").text
        @amenities << amenities
        @amenities[0].gsub!("\t\t\t\t\t\t\t\t", "")
        puts
        puts "Amenities:"
        puts "=========="
        puts @amenities
        puts 
        puts "($) = Additional Charge"
        puts
        puts
    end

end