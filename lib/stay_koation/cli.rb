require "pry"

class StayKoation::CLI

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
        Campground.view_amenitites_selection
        binding.pry
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
    end

end