class HangpersonGame

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    raise ArgumentError if !letter or !letter.match(/\w+/)
    if @guesses.downcase.include? letter.downcase or @wrong_guesses.downcase.include? letter.downcase
      return false
    end
    if @word.downcase.include? letter.downcase
      @guesses = @guesses << letter
    else
      @wrong_guesses = @wrong_guesses << letter
    end
    return true
  end
  
  def word_with_guesses()
    pattern = Regexp.new("[^" + (@guesses.empty? ? "\w" : @guesses) + "]", Regexp::IGNORECASE)
    return @word.gsub(pattern, "-")
  end
  
  def check_win_or_lose()
    return :lose if wrong_guesses.length >= 7
    return :win if !word_with_guesses().include? "-"
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
