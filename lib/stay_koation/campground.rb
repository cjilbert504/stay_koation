require 'pry'

class Campground

    attr_accessor :name, :amenities, :state_pick, :campgrounds_array, :view_selection
    
 

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

    def view_amenities_prompt
        puts "Please enter the number of the campground whose amenities you would like to view:"
        @view_selection = input.gets.strip.to_i
    end


    # name = "Dectaur / Wheeler Lake KOA"
    # name.gsub!("KOA", "")
    # url_name = name.split("/")
    # puts url_name[0].downcase
    
end