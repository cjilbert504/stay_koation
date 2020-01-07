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

    # This method takes in the user selection from the state_select_prompt to be used in the 
    # scrape_koa_campgrounds method
    def self.state_select(state)
        @state_pick = state
    end

    # This method scrapes the select state url to get a list of the campgrounds in that state 
    # and parses them as needed
    def self.scrape_koa_campgrounds
        doc = Nokogiri::HTML(open("#{@state_pick}"))
        campgrounds = doc.search("div.media-heading").text
        @campgrounds_array = campgrounds.split(" KOA")
    end

    # This method creates new instances of Campground from the scraped array
    def self.new_from_scrape
        @campgrounds_array.each {|x| x = self.new(x)}
    end

    # This method iterates over the @@all array and creates a numbered menu with the stored elements
    def self.campground_menu
        counter = 1
        puts
        self.all.each do |x| 
            puts "#{counter}. #{x.name}"
            counter += 1
        end
    end

    # This method prompts the user for a campground selection in order to view its amenities
    def self.view_amenities_selection 
        puts "Please select the number of the campground whose amenities you would like to view:"
        @view_selection = gets.strip.to_i
    end

    # This method takes the users input, selects the appropriate campground from the @@all array
    # and formats its name in order to be used to scrape its url
    # Maybe this should be an instance method
    def self.campground_name_normalize
        name = Campground.all[@view_selection-1].name
        name.gsub!(" KOA", "")
        url_name = name.split(" / ")
        @amenities_url = url_name[0].downcase.gsub(" ", "-")
    end

    # This method scrapes the amenities of the selected campground and displays them to the user
    # Maybe this should be an instance method
    def self.amenities_scrape
        doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
        amenities = doc.search("ul.gray-bullet-list.row").text
        amenities_array = amenities
        puts
        puts "Amenities:"
        puts "=========="
        puts amenities_array.gsub("\t", "")
        puts 
        puts "($) = Additional Charge"
        puts
        puts
    end

end