class Game
  attr_accessor :lines

  def initialize
    @lines = lines
  end

  def display_random_word(file_path)
    lines = File.readlines(file_path)       # read the entire file
    random_index = rand(lines.length)       # generate a random index
    hide_word(lines[random_index].chomp)    # get the line from the index and remove the newline character using chomp
  end

  def hide_word(hidden_word)
    correct_word = hidden_word.split('')               # split the word into an array of letters
    hidden_word = hidden_word.downcase.gsub(/[a-z]/, '_')     # replace the letters by _
    puts hidden_word
    play(correct_word, hidden_word)
  end

  def user_input(used_letters)
    input = ""

    loop do
      puts "Enter a letter: "
      input = gets.chomp.downcase
      if(used_letters.join().include?(input))                     # check for same letter
        puts "\e[31m Please enter a different letter!! \e[0m"
        next
      end
      break if input.match?(/\A[a-z]\z/)                          # check for single letter
      puts "\e[31m Invalid input! Please enter a single letter!!\e[0m"
    end

    input
  end

  def play(correct_word, hidden_word)
    count = 0
    used_letters = []

    while count < 10
      puts "\n"
      input = user_input(used_letters)
      used_letters << input               # adding the user input to the array

      if(correct_word.include?(input))
        puts "\e[44mCorrect Guess!\e[0m"
        replace_letter(input, correct_word, hidden_word)
        if hidden_word.include?('_')
          next
        else
          won?
          break
        end
      else
        count += 1
      end

      puts "Letters used: #{used_letters.join(" ")}"
      puts "\e[31mRemaining tries: #{10 - count}\e[0m" unless count == 9
    end
    if count == 10
      lose?
      puts "The correct word is: \e[31m#{correct_word.join()}\e[0m"
    end

  end

  def replace_letter(input, correct_word, hidden_word)    # replace _ with correct letter
    correct_word.each_with_index do |letter, index|
      hidden_word[index] = input if letter == input
    end
    p hidden_word
  end

  def won?
    puts "You guessed the word correctly! You win!! "
    true
  end

  def lose?
    puts "\e[31m You lost!! \e[0m"
    true
  end
end

random_word = Game.new
random_word.display_random_word('google-10000-english-no-swears.txt')
