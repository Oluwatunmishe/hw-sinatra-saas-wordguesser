class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses 

  def initialize(word)
    
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    
    
  end
  def check_win_or_lose 
   if word_with_guesses == @word
    :win
   elsif @wrong_guesses.length >= 7
    :lose
   else
    :play
   end 
  end 


  def word_with_guesses
    res = ""
    @word.each_char do |letter|
      if @guesses.include?(letter)
        res << letter
      else
        res << "-"
      end
    end
    res
      
  end 
  def guess(letters)
    letters = letters.to_s.downcase
    raise ArgumentError if letters.nil? || letters.empty? || !letters.match?(/^[a-zA-Z]$/)

    
    
    if @guesses.include?(letters) || @wrong_guesses.include?(letters)
        return false
    elsif @word.include?(letters)
        @guesses << letters
    else
      @wrong_guesses << letters
    
    end
  
  end



  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.get(uri.path)
      return response.body.scan(/<div>(.+?)<\/div>/).flatten.first
    end
  end
end
