require "pry"

class StayKoation::CLI

        
        
    def call
        welcome_image 
        State.scrape_koa_states    
        sleep 3
        new_user_greeting 
        sleep 2 
        state_select_prompt 
        sleep 4
        state_user_input
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
        puts "Please enter your first name or press enter to continue as a guest:"
        user_name = gets.strip.downcase.capitalize
            if user_name.to_i > 0
                puts
                puts "Invalid input, please try again"
                new_user_greeting
            elsif user_name == "" 
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
        sleep 4
        State.list_display
    end

    def state_user_input
        puts "Enter your number selection here:"
        state_selection = gets.strip.to_i
            if state_selection <= 0 || state_selection > State.all.length || state_selection == String
                puts "Wrong input for selection, please try again."
                state_user_input
            else
                state_pick = State.all[state_selection - 1]
                Campground.scrape_koa_campgrounds(state_pick)
            end
        end

    def view_amenities_prompt
        puts "Please select the number of the campground whose amenities you would like to view:"
        selection = gets.strip.to_i 
        if selection <= 0 || selection > Campground.all.length || selection == String
            puts "Wrong input for selection, please try again."
            view_amenities_prompt
        else
            camp = Campground.all[selection - 1]
            camp.get_amenities(camp, self)
        end
    end

    def rerun_app
        puts "If you would like to search states again enter (y) or to exit the program enter (n)"
        choice = gets.chomp
            case choice.downcase
                when "y"
                    Campground.all.clear
                    state_select_prompt 
                    sleep 4
                    state_user_input
                    Campground.campground_menu
                    view_amenities_prompt
                    rerun_app
                when "n"
                    end_app
                else
                   puts "Invalid input"
                   rerun_app
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