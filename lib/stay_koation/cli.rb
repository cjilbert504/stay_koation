require "pry"

class StayKoation::CLI

    # This method controls the UI and the flow of the program
    def call
        welcome_image
        sleep 3
        new_user_greeting
        sleep 2
        State.scrape_koa_states
        state_select_prompt
        Campground.scrape_koa_campgrounds
        Campground.new_from_scrape
        Campground.campground_menu
        Campground.view_amenities_selection
        Campground.campground_name_normalize
        Campground.amenities_scrape
    end

    # This is the method that "welcomes" the user to the program
    def welcome_image
        puts
        puts "============================"
        puts "= Welcome to Stay KOAtion! ="
        puts "============================"
    end

    # This method is responsible for instantiating a new User instance and greets the user
    def new_user_greeting
        puts
        puts "Please enter your first name:"
        user_name = gets.strip.downcase.capitalize
        User.new(user_name)
        puts
        puts "Hello, #{user_name}!"
    end

    # This method prompts the user to select a state, displays the state select menu, gets the users
    # selection, gets the selected states url attribute and passes it to the Campground state_select
    # method to then be used by the Campground..scrape_koa_campgrounds method; Perhaps this belongs 
    # in the State class and probably needs to be refactored into smaller methods that only do one job
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
    end

end