# frozen_string_literal: true

require '../lib/film'

describe Film do
  describe '.new' do
    it 'creates new object with given title, director, year' do
      film = described_class.new('Список Шиндлера', 'Стивен Спилберг', '1993')

      expect(film.title).to eq 'Список Шиндлера'
      expect(film.director).to eq 'Стивен Спилберг'
      expect(film.year).to eq '1993'
    end
  end

  describe '#to_s' do
    it 'returns a string with all the data' do
      film = described_class.new('Список Шиндлера', 'Стивен Спилберг', '1993')

      expect(film.to_s).to eq 'Список Шиндлера - Стивен Спилберг - 1993'
    end
  end
end
