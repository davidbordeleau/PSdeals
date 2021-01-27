require 'open-uri'
require 'nokogiri'
module DashboardsHelper
  def fetch_games
    url = "https://store.playstation.com/en-Ca/category/35027334-375e-423b-b500-0d4d85eff784/1"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.ems-sdk-product-tile-list .truncate-text-2').each do |cell|
      puts cell.text.strip
    end
  end
end
