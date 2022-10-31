# frozen_string_literal: true

require '../lib/film'
require '../lib/film_collection'
require 'byebug'

describe FilmCollection do
  describe '#from_imdb' do
    before do
      open_url = File.open("#{__dir__}/fixtures/top250.html")
      allow(described_class).to receive(:open_url).and_return open_url
    end
    it 'should return array of films' do
      films = described_class.from_imdb

      expect(films).to be_an Array
      expect(films).to all be_an Film
      expect(films.size).to eq 50
    end

    it 'should return correct data' do
      topgun = described_class.from_imdb.first

      expect(topgun.title).to eq 'Top Gun: Maverick'
      expect(topgun.director).to eq 'Joseph Kosinski'
      expect(topgun.year).to eq '(2022)'
    end
  end

  describe '#directors' do
    before do
      open_url = File.open("#{__dir__}/fixtures/top250.html")
      allow(described_class).to receive(:open_url).and_return open_url
    end
    it 'should return uniq directors' do
      films = described_class.from_imdb
      directors = described_class.directors(films)
      expect(directors.size).to eq 43
    end
  end
end
