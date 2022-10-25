require 'nokogiri'
require 'open-uri'

require_relative 'lib/film'
require_relative 'lib/film_collection'

films = FilmCollection.from_imdb
puts "Let's choose a movie. Please, select a director: \n\n"

directors = FilmCollection.directors(films)

directors.each_with_index do |director, index|
  puts "#{index + 1}. #{director}"
end

puts
puts 'Which film director do you want to see today? '

user_input = 0

until user_input.between?(1, directors.size)
  puts "Choose a number from 1 to #{directors.size}"
  user_input = STDIN.gets.to_i
end

puts
puts 'And today we recommend to watch:'

puts films.select { |film| film.director == directors[user_input.to_i - 1] }.sample
