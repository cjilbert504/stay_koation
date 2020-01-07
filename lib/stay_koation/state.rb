require 'pry'

class State

    attr_accessor :name, :url

    @@all = []

    def initialize(name)
        @name = name
        @campgrounds = []
        @url = "https://koa.com/states-provinces/#{@name.downcase.gsub(" ", "-")}/"
        @@all << self
    end

    def self.all
        @@all
    end

    def self.scrape_koa_states
        doc = Nokogiri::HTML(open("https://koa.com/campgrounds/"))
        states = doc.search("a h4").text
        states_array = states.split("Campgrounds in ")
        new_array = states_array[1, 47]
        new_array.each {|s| s = self.new(s)}
   end

    def self.list_display
        puts "------------------------------------------------------------------------------------------------------"
        puts " 1. #{self.all[0].name}           2. #{self.all[1].name}           3. #{self.all[2].name}        4. #{self.all[3].name}            5. #{self.all[4].name}"
        puts " 6. #{self.all[5].name}          7. #{self.all[6].name}      8. #{self.all[7].name}        9. #{self.all[8].name}            10. #{self.all[9].name}"
        puts "11. #{self.all[10].name}         12. #{self.all[11].name}         13. #{self.all[12].name}          14. #{self.all[13].name}             15. #{self.all[14].name}"
        puts "16. #{self.all[15].name}        17. #{self.all[16].name}           18. #{self.all[17].name}      19. #{self.all[18].name}      20. #{self.all[19].name}"
        puts "21. #{self.all[20].name}        22. #{self.all[21].name}     23. #{self.all[22].name}      24. #{self.all[23].name}            25. #{self.all[24].name}"
        puts "26. #{self.all[25].name}           27. #{self.all[26].name}   28. #{self.all[27].name}    29. #{self.all[28].name}         30. #{self.all[29].name}"
        puts "31. #{self.all[30].name}   32. #{self.all[31].name}    33. #{self.all[32].name}          34. #{self.all[33].name}           35. #{self.all[34].name}"
        puts "36. #{self.all[35].name}     37. #{self.all[36].name}  38. #{self.all[37].name}  39. #{self.all[38].name}          40. #{self.all[39].name}"
        puts "41. #{self.all[40].name}             42. #{self.all[41].name}         43. #{self.all[42].name}      44. #{self.all[43].name}         45. #{self.all[44].name}"
        puts "46. #{self.all[45].name}        47. #{self.all[46].name}"
        puts "------------------------------------------------------------------------------------------------------"
        puts
    end

    def add_campgrounds(campgrounds)
        campgrounds.each do |x|
            @campgrounds << x
            x.state = self
        end
    end

end