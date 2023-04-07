class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
    end

    def create
     puts params
    end

    def update
     puts 'Running update in users controller'
    end

    def my_custom_action
        puts 'THIS IS THE ID:   '
        puts params['id']
        # puts "Params in my custom action in UsersController"
        # puts params
    end
end
