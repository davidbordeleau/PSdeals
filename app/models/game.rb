require 'open-uri'
require 'nokogiri'

class Game < ApplicationRecord
  def self.create_games
    url = 'https://store.playstation.com/en-Ca/category/35027334-375e-423b-b500-0d4d85eff784/1'

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.cell:not(:first-child)').each do |cell|
      next unless cell.search('img').attribute('src')

      game = Game.new
      game.name = cell.search('.psw-p-t-2xs').text.strip
      game.cover_url = normalize_cover_url(game.name)
      game.discount = cell.search('.discount-badge').text
      game.current_price, game.previous_price = fetch_prices(cell.search('.price').text)

      game.save
      fetch_image(cell)
    end
  end

  def self.fetch_image(cell)
    system("curl -o app/assets/images/#{cover_url}.jpg #{cell.search('img').attribute('src').value.split('?').first}")
    self.resize_image
  end

  def self.resize_image
    system("magick app/assets/images/#{cover_url}.jpg -resize 150x150 app/assets/images/#{cover_url}.jpg")
  end

  def self.fetch_prices(cell)
    price_data = cell.match(/(\$[0-9]{1,3}\.?[0-9]?{1,3})(\$[0-9]{1,3}\.?[0-9]?{1,3})/)
    [price_data[1], price_data[2]]
  end

  def self.normalize_cover_url(attribute)
    attribute.downcase.gsub(/[^a-zA-Z ]+/, '').strip.gsub(' ', '_')
  end
end
