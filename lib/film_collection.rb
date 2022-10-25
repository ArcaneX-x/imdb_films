module FilmCollection
  IMDB_URL = 'https://www.imdb.com/chart/top/?sort=us,desc&mode=simple&page=1'

  def self.from_imdb

    films = []
    doc = Nokogiri::HTML(URI.open(IMDB_URL))

    doc.css('.titleColumn').first(50).each do |film|
      title = film.css('a').text
      director = film.css('a').first.attributes["title"].value.split(' (').delete_at(0)
      year = film.css('.secondaryInfo').text
      unless title.empty? && director.empty? && year.nil?
        films << Film.new(title, director, year)
      end
    end
    films
  end

  def self.directors(films)
    films.map(&:director).uniq.sort
  end
end
