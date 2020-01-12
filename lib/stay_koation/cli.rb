require "pry"

class StayKoation::CLI

        
        
    def call
        welcome_image    
        sleep 3
        new_user_greeting 
        sleep 2 
        state_select_prompt 
        sleep 4
        state_user_input
        Campground.scrape_koa_campgrounds 
        Campground.campground_menu
        view_amenities_prompt
        rerun_app
    end

    def welcome_image
        puts
        puts "============================"
        puts "= Welcome to Stay KOAtion! ="
        puts "============================"
        puts
    end

    def new_user_greeting
        puts "Please enter your first name:"
        user_name = gets.strip.downcase.capitalize
            if user_name == ""
                puts
                puts "Hello there you unidentified seeker of sites you!"
            else
                User.new(user_name)
                puts
                puts "Hello, #{user_name}!"
            end
    end

    def state_select_prompt
        puts
        puts "Please select the number of the state in which you would like to start your KOA campsite search from the following list:"
        State.scrape_koa_states 
        sleep 4
        State.list_display
    end

    def state_user_input
        puts "Enter your number selection here:"
        state_selection = gets.strip.to_i
        state_pick = State.all[state_selection-1]
        Campground.state_select(state_pick)
    end

    def view_amenities_prompt
        puts "Please select the number of the campground whose amenities you would like to view:"
        selection = gets.strip.to_i - 1
        camp = Campground.all[selection]
        camp.get_amenities(camp)
    end

    def rerun_app
        puts "If you would like to search states again enter (y) or to exit the program enter (n)"
        choice = gets.chomp
            case choice.downcase
                when "y"
                    Campground.all.clear
                    State.all.clear
                    state_select_prompt 
                    sleep 4
                    state_user_input
                    Campground.scrape_koa_campgrounds 
                    Campground.campground_menu
                    view_amenities_prompt
                    rerun_app
                when "n"
                    end_app
                end
    end

    def end_app
        puts
        puts "Thanks and we hope you enjoy your next Stay KOAtion!!!"
        puts
        puts
        abort
    end

end