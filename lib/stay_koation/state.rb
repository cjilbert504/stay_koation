require 'pry'

class State

    attr_accessor :name, :url

    @@all = ["Alabama", "Alaska", "Arizona" , "Arkansas", "California",
            "Colorado", "Connecticut", "Florida", "Georgia", "Idaho", "New York"]

    def initialize(name)
        @name = name
        @cities = []
        @url = "https://koa.com/states-provinces/#{@name.to_s.downcase.gsub(" ", "-")}/"
        @@all << self
    end

    def self.all
        @@all
    end

    def self.list_display
        puts "--------------------------------------------------------------------------------"
        puts "1. #{self.all[0]}    2. #{self.all[1]}        3. #{self.all[2]}   4. #{self.all[3]}    5. #{self.all[4]}"
        puts "6. #{self.all[5]}   7. #{self.all[6]}   8. #{self.all[7]}   9. #{self.all[8]}    10. #{self.all[9]}"
        puts "--------------------------------------------------------------------------------"
        puts
    end

    def self.scrape_koa_states
        doc = Nokogiri::HTML(open("https://koa.com/campgrounds/"))
        title = doc.search("h4").text
        title_array = title.split.map {|c| c}
        state_array = title_array.delete_if{|ele| ele == "in"}
        state_array.map {|ele| ele.gsub("Campgrounds", "")}
        binding.pry
    end

    #title_array.map {|c| c.gsub("Campgrounds", "").

end