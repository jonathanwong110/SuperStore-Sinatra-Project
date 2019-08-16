class UniqloShopper::CLI
  
  def call
    list_shirts(nil)
    clothes
    goodbye
  end
  
  def list_shirts(keyword=nil)
    puts "Today's T-Shirts:"
    UniqloShopper::Scraper.scrape_shirts
    UniqloShopper::Shirt.find_shirts(keyword).each.with_index do |shirt, i|
      puts "#{i+1}. #{shirt.name}"
    end
  end
  
  def clothes
    input = nil
    while input != "exit"
      puts "Enter the number of the product you want more information on or type list to see the list of products again or type exit:"
      input = gets.strip.downcase
      
      if input.to_i > 0
        the_shirt = UniqloShopper::Shirt.all[input.to_i-1]
        if the_shirt
          puts "#{the_shirt.name} - #{the_shirt.price} - #{the_shirt.url}
          "
        else
          puts "Error, please try again"
        end
      elsif input == "list"
        list_shirts(nil)
      elsif UniqloShopper::Shirt.find_if_keyword(input)
        list_shirts(input)
      else
        puts "Error, please try again"
      end
    end
  end
  
  def goodbye
    puts "Check at a later time for updates"
  end
  
end

