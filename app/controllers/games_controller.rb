require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    if in_grid?(@word, @letters)
      @result = valid_word? ? 'Well done!' : 'not an english word'
    else
      @result = "can't be build"
    end
  end

  private

  def valid_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def in_grid?(word, letters)
    array = word.split('')
    array.all? { |e| array.count(e) <= letters.count(e) }
  end
end
