class City

    attr_accessor :name, :campsites, :states

    @@all = []
    
    def initialize(name)
        @name = name
        @campsites = []
        @@all << self
    end


end