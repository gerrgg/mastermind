require './feedback'

class MasterMind
    def initialize(secret)
        @max_attempts = 10
        @attempts = 1
        @secret = secret
        @RED="\e[31m"
        @BLUE="\e[34m"
        @GREEN="\e[32m"
        @YELLOW="\e[33m"
        @RESET="\e[0m"
        @BOLD = "\e[1m"
        @correct = false
    end

    def play
        while @attempts < @max_attempts && !@correct do
            puts "\n#{@BOLD}MASTERMIND#{@RESET}\n"
            puts "Attempt: #{@attempts}/#{@max_attempts}\n\n"
            guess = get_player_guess()

            # do the logic to determine the correct color/position
            @correct = provide_feedback(guess)

            @attempts+= 1
        end

        if @correct
            puts "You won!"
            exit
        else
            puts "you lost, the secret was #{@secret}"
            exit
        end
    end

    def provide_feedback(guess)
        feedback = Feedback.new(guess, @secret)
        feedback.check()
        if feedback.correct_position == @secret.length
            return true
        else
            puts "Correct Position: #{feedback.correct_position}\n"
            puts "Correct Color Wrong Position: #{feedback.correct_color}\n"
        end
    end

    def get_player_guess
        valid = false
        guess = []

        while ! valid do
            puts "1) #{@RED}Red#{@RESET}\n"
            puts "2) #{@BLUE}Blue#{@RESET}\n"
            puts "3) #{@GREEN}GREEN#{@RESET}\n"
            puts "4) #{@YELLOW}YELLOW#{@RESET}\n"
            puts "\nPlease enter your guess seperated by spaces (1 2 3 4): \n"
        
            guess = gets.chomp
            guess_array = guess.split(' ').map(&:to_i).select { |n| n >=1 && n <= 4 }

            if guess_array.length == 4
                valid = true
                return guess_array
            else 
                puts "\nInvalid response, please use numbers 1-4 and seperate them by spaces (1 2 3 4)\n\n"
            end
        end
    end
end

game = MasterMind.new(Array.new(4) { rand(1..4) })
game.play()