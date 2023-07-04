=begin
When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.

You don’t need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses they have before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.

Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.

Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects… you can serialize your game class too!

When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!
=end


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

  def hide_word(word)
    correct_word = word.split('')               # split the word into an array of letters
    word = word.downcase.gsub(/[a-z]/, '_')     # replace the letters by _
    puts word
    puts correct_word.join()                    # print the original word as a string
    play(correct_word)
  end

  def user_input
    input = ""
    loop do
      puts "Enter a letter: "
      input = gets.chomp.downcase
      break if input.match?(/\A[a-z]\z/)
      puts "\e[31m Invalid input! Please enter a single letter!!\e[0m"
    end
    input
  end

  def play(correct_word)
    count = 0
    used_letters = []
    while count < 10
      input = user_input
      used_letters << input
      count += 1
      puts "Letters used: #{used_letters.join(" ")}"
      puts "\e[31mRemaining tries: #{10 - count}\e[0m" unless count == 9
    end
    puts "\e[31m You lost!! \e[0m"
    puts "The correct word is: #{correct_word.join()}"
  end
end


random_word = Game.new
random_word.display_random_word('google-10000-english-no-swears.txt')
