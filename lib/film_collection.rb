module FilmCollection
  IMDB_URL = 'https://www.imdb.com/chart/top/?sort=us,desc&mode=simple&page=1'

  def self.from_imdb
    html_page = KINOPOISK_URL.gsub('[', '%5B').gsub(']', '%5D')

    films = []
    doc = Nokogiri::HTML(URI.open(html_page))

    doc.css('div .item').each do |film|
      title = film.css('.info .name a').text
      director = film.css('.info .gray_text i .lined').text
      year = film.css('.info .name span').text.split(' ').find { |string| string.match('\([0-9]{4}\)') }
      year.delete!('()') unless year.nil?

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
