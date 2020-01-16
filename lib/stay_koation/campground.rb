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

    def self.scrape_koa_campgrounds(state)
        @state_pick = state
        if @state_pick.campgrounds.empty?

            doc = Nokogiri::HTML(open("#{@state_pick.url}"))
            campgrounds = doc.search("div.media-heading").text
            campgrounds_array = campgrounds.split(" KOA")
            Campground.new_from_scrape(campgrounds_array)
        end
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
        puts
    end

    def get_amenities(camp, cli_inst)
        camp.campground_name_normalize(cli_inst)
    end

    def campground_name_normalize(cli_inst)
        url_name = @name.split(" / ")
        @amenities_url = url_name[0].downcase.gsub(" ", "-")
        amenities_scrape(cli_inst)
    end

    def amenities_scrape(cli_inst)
        if @amenities.empty?
        begin
            doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
        rescue
            begin
            url_name = @name.split(" / ")
            @amenities_url = url_name[1].downcase.gsub(" ", "-")
            doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
            #binding.pry
            rescue
                puts "SORRY! No further information can be gathered at this time."
                sleep 3
                Campground.campground_menu
                cli_inst.view_amenities_prompt
                cli_inst.rerun_app
            end
        end
        #doc = Nokogiri::HTML(open("https://koa.com/campgrounds/#{@amenities_url}/"))
        amenities = doc.search("ul.gray-bullet-list.row").text
        @amenities << amenities
    end
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