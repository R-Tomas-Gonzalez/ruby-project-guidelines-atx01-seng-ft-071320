require'pry'
class User < ActiveRecord::Base
    has_many :user_articles
    has_many :articles, through: :user_articles

    def self.create_user
        new_user = User.new
        new_user.username = self.set_username
        new_user.password = self.set_password
        new_user.save
        Controller.intro
    end

    def self.set_username
        given_username = PROMPT.ask("** What do you wnat your username to be?:") do |q|
            q.validate(/^([0-9]*[a-zA-Z][a-zA-Z0-9]*)$/)
            q.messages[:valid?] = '** Your username can only letters and numbers. **'
        end
        yes_or_no = PROMPT.yes?("** '#{given_username}' is what you entered. Are you sure? **")
            if yes_or_no
                if User.find_by(username:given_username) == nil 
                   given_username
                else
                    puts "** Sorry, '#{given_username}' is already taken. Please try with different username. **"
                    self.set_username                
                end
            else 
                self.set_username
            end
        puts "** Great, your username is now '#{given_username}'. **"   
            given_username
    end 

    def self.set_password
        puts "** Now, let's set your password now! **"
        puts "** Your password must be only numbers. **"
        given_password = PROMPT.mask("** Please enter your password: ") do |q|
            q.validate(/^([0-9])*$/)
            q.messages[:valid?] = '** Your password must be only numbers. **'
        end
        confirm_password = PROMPT.mask("** Please confirm your password: ") 
            if given_password == confirm_password
               puts "** Perfect! Don't forget your username and password! **"
            else
                puts "** uh-uh, they're not matching. Let's just start over. **"             
                self.set_password
            end 
        given_password
    end    
    
    def self.login
        self.find_username
    end

    def self.find_username
        puts "** Please enter your username. **"
        given_username = gets.chomp
        if User.find_by(username:given_username) == nil
            puts "** We can't find the username. **"
            yes_or_no = PROMPT.yes?("** Would you like try again? **")
            if yes_or_no
                self.find_username
            else 
                exit
            end
            self.find_username
        else User.find_by(username:given_username)
            @@current_user = User.find_by(username:given_username)
            given_password = PROMPT.mask("** Please enter your password: ")
            @@current_user.password = given_password
        end
        Controller.intro
    end


end # end User
