require "pry"

class StayKoation::CLI

        attr_accessor :state_obj
        
        #-------------------------------------- Starting at an instance level of the CLI class
    def call
        welcome_image   #---------------------- called on instance of CLI class 
        sleep 3
        new_user_greeting #-------------------- called on instance of CLI class
        sleep 2
        State.scrape_koa_states #-------------- called on the State class to make all of the new State objects
        state_select_prompt #------------------ called on instance of CLI class; returns a State object
        Campground.scrape_koa_campgrounds #---- called on Campground class to scrape web and parse data into an array
        Campground.new_from_scrape #----------- called on Campground class to make all of the new Campground objects
        Campground.campground_menu
        Campground.view_amenities_selection
        Campground.campground_name_normalize
        Campground.amenities_scrape
    end

    def welcome_image
        puts
        puts "============================"
        puts "= Welcome to Stay KOAtion! ="
        puts "============================"
    end

    def new_user_greeting
        puts
        puts "Please enter your first name:"
        user_name = gets.strip.downcase.capitalize
        User.new(user_name)
        puts
        puts "Hello, #{user_name}!"
    end

    def state_select_prompt
        puts
        puts "Please select the number of the state in which you would like to start your KOA campsite search from the following list:"
        sleep 4
        State.list_display
        sleep 4
        puts "Enter your number selection here:"
        state_selection = gets.strip.to_i
        state_pick = State.all[state_selection-1].url
        Campground.state_select(state_pick)
        @state_obj = State.all[state_selection-1]
        binding.pry
    end

end