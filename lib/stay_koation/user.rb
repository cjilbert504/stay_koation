class User

    attr_accessor :name, :saved_sites

    @@all = []

    def initialize(name)
        @name = name
        @saved_sites = []
        @@all << self
    end

    def self.all
        @@all
    end

    def save_campground(campground)
        @saved_sites << campground
    end

end