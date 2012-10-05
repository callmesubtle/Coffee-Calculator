class Coffee

  attr_accessor :name, :price, :shipping, :weight, :weight_type, :cup_dosing, :people, :total_price, :cups, :price_per_cup, :total_price_shared, :cups_shared, :weight_shared, :weight_in_ounces_shared, :count

  @@count = 1

  def initialize
    get_coffee_details
    coffee_summary_single
    coffee_summary_shared
    @@count += 1
  end

  def differences(other)
    more_expensive = price_per_cup > other.price_per_cup ? name : other.name
    less_expensive = price_per_cup < other.price_per_cup ? name : other.name
    price_per_cup_difference = price_per_cup - other.price_per_cup
    puts "#{less_expensive} is cheaper than #{more_expensive} by: $#{price_per_cup_difference.abs.round(2)}"
  end

  def get_coffee_details
    puts ""
    print "Enter name for Coffee ##{@@count}: "
    @name = gets.chomp
    @name = "Coffee ##{@@count}" unless name != '' # If name is blank then default is Coffee + count
    @price = 0 # Price is required
    until price > 0
      print "Enter price: "
      @price = gets.chomp.gsub("$", '').to_f
    end
    print "Enter shipping: "
    @shipping = gets.chomp.gsub("$", '').to_f # Will set to 0.0 if blank
    print "Enter the weight and unit (Default = 12 oz.): "
    @weight = gets.chomp
    if weight["oz"] || weight["oz."] || weight["ounce"] || weight["ounces"]
      @weight_type = "ounces"
    elsif weight["lb"] || weight["lbs"] || weight["pound"] || weight["pounds"]
      @weight_type = "pounds"
    else
      @weight_type = "grams"
    end
    @weight = weight.scan(/\d+/)[0].to_i
    @weight = 340 unless weight > 0 # Sets default to 340 grams or 12 oz if blank.
    if weight_type == "ounces"
      @weight = weight * 28.34
    elsif weight_type == "pounds"
      @weight = weight * 453.592
    end
    @weight_type = "grams"
    print "Grams per cup? (Default = 20 grams): "
    @cup_dosing = gets.chomp.to_i
    @cup_dosing = 20 unless cup_dosing > 0 # Sets default to 20 grams if blank
    print "How many friends are you sharing this with? (Default = 0): "
    @people = gets.chomp.to_i # Will set to 0 if blank
  end

  def coffee_summary_single
    @total_price = price + shipping
    @cups = weight / cup_dosing
    @price_per_cup = total_price / cups
    puts ""
    puts "Total price: $#{total_price.round(2)}"
    puts "Total cups: #{cups.round(0)}"
    puts "Price per cup: $#{price_per_cup.round(2)}"
  end

  def coffee_summary_shared
    unless people <= 1
      @total_price_shared = total_price / people
      @cups_shared = cups / people
      @weight_shared = weight / people
      @weight_in_ounces_shared = (weight * 0.035274) / people
      puts ""
      puts "Total price (split by #{people}): $#{total_price_shared.round(2)}"
      puts "Total cups per person: #{cups_shared.round(0)} cups"
      puts "Weight (split by #{people}): #{weight_shared.round(0)} grams or #{weight_in_ounces_shared.round(0)} oz."
    end
  end

end

# Create Objects

c1 = Coffee.new

puts ""
print "Do you want to compare coffees? (yes/no): "
compare = gets.chomp
if compare == "yes"
  c2 = Coffee.new
  puts ''
  c1.differences(c2)
else
  puts "Ok"
  abort
end
