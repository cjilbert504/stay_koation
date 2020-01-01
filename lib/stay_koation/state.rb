require 'pry'

class State

    attr_accessor :name, :url

    @@all = []

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
        puts "1. #{self.all[0].name}    2. #{self.all[1].name}        3. #{self.all[2].name}   4. #{self.all[3].name}    5. #{self.all[4].name}"
        puts "6. #{self.all[5].name}   7. #{self.all[6].name}   8. #{self.all[7].name}   9. #{self.all[8].name}    10. #{self.all[9].name}"
        puts "--------------------------------------------------------------------------------"
        puts
    end

    def self.scrape_koa_states
         doc = Nokogiri::HTML(open("https://koa.com/campgrounds/"))
         states = doc.search("a h4").text
         states_array = states.split("Campgrounds in ")
         new_array = states_array[1, 47]
         new_array.each {|s| s = self.new(s)}
         #binding.pry
    end

end