class UniqloShopper::Shirt

  attr_accessor :name, :price, :url
  
  @@all = []

  def initialize(name:, price:, url:)
    @name = name
    @price = price
    @url = url
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def keyword
    @keyword
  end

  def self.find_shirts(keyword=nil)
    if keyword == nil
      return @@all
    end
    @@all.find_all { |shirt| shirt.name.upcase.include?(keyword.upcase) }
  end
  
  def self.find_if_keyword(keyword)
    listed = @@all.find { |shirt| shirt.name.upcase.include?(keyword.upcase) }
    return listed
  end

end
