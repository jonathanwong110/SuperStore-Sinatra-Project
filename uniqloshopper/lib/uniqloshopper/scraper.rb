class UniqloShopper::Scraper

  def self.scrape_shirts
    if UniqloShopper::Shirt.all.length == 0
      doc = Nokogiri::HTML(open("https://www.uniqlo.com/us/en/men/t-shirts"))
      doc.css("div.product-tile").each do |section|
        item = {
          :name => section.css("div.product-name a.name-link").text,
          :price => section.css("div.product-pricing span").last.text,
          :url => section.css("div.product-name a.name-link").attribute("href").value
        }
        UniqloShopper::Shirt.new(item)
      end
    end
  end
end
