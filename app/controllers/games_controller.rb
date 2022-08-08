require "json"
require "open-uri"

url = "https://wagon-dictionary.herokuapp.com/"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    response = JSON.parse(user_serialized)
    if response["found"] == true && includes?(@word, @letters)
      @includes = "You Win"
    else
      @includes = "You Lose"
    end

  end

  def includes?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }

  end

end
