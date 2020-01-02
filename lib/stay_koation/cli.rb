require "pry"

class StayKoation::CLI

    attr_accessor :state

    def call
        welcome_image
        sleep 3
        new_user
        sleep 2
        State.scrape_koa_states
        state_select_prompt
        #binding.pry
    end

    def welcome_image
        puts
        puts "============================"
        puts "= Welcome to Stay KOAtion! ="
        puts "============================"
    end

    def new_user
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
        state = State.all[state_selection-1].url
        puts state
        # Remove above puts statement after testing method output to the cities class
    end

end