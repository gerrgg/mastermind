class Feedback
  attr_reader :correct_position, :correct_color
  
  def initialize(guess, secret)
    @guess = guess
    @secret = secret
    @correct_position = 0
    @correct_color = 0
    @used_in_guess = [false] * guess.length
    @used_in_secret = [false] * secret.length
  end

  # Check for exact matches (correct color and position)
  def check_for_exact_matches
    @guess.each_with_index do |item, index|
      if item == @secret[index]
        @correct_position += 1
        @used_in_secret[index] = true
        @used_in_guess[index] = true
      end
    end
  end

  # Check for color matches in wrong positions
  def check_for_correct_colors_in_wrong_position
    @guess.each_with_index do |item, i|
      next if @used_in_guess[i]  # Skip already matched guesses

      @secret.each_with_index do |secret_item, j|
        next if @used_in_secret[j]  # Skip already matched secrets

        if item == secret_item
          @correct_color += 1
          @used_in_secret[j] = true
          @used_in_guess[i] = true  # Mark the guess as used
          break
        end
      end
    end
  end

  # Main check method that combines both checks
  def check
    check_for_exact_matches
    check_for_correct_colors_in_wrong_position
  end
end
