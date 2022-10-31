# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
class FilmCollection
  IMDB_URL = 'https://www.imdb.com/chart/top/?sort=us,desc&mode=simple&page=1'

  class << self
    def from_imdb
      films = []

      html = open_url(IMDB_URL)
      doc = Nokogiri::HTML(html)
      html.close

      doc.css('.titleColumn').first(50).each do |film|
        title = film.css('a').text
        director = film.css('a').first.attributes['title'].value.split(' (').delete_at(0)
        year = film.css('.secondaryInfo').text
        films << Film.new(title, director, year) unless title.empty? && director.empty? && year.nil?
      end
      films
    end

    def directors(films)
      films.map(&:director).uniq.sort
    end

    private

    def open_url(page)
      URI.open(page)
    end
  end
end
