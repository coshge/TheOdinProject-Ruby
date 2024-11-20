##
## The Odin Project
## Project 3 - Stock Picker
###

# Iterate through the array of prices, choosing the best time to buy and sell for maximum profit
def stock_picker(prices)
  # Return early if empty or one-element prices array
  if prices.empty? || prices.length == 1
    puts "Not enough data to make a profit (need at least 2 prices)."
    return
  end
  
  lowest = prices[0]  # Current lowest buy price
  lowest_index = 0    # Index of the current lowest price
  max_profit = 0      # Current highest profit
  result = []         # Holds current best buy/sell days' prices

  # Iterate through the prices array to find the best buy/sell days
  prices.each_with_index do |price, index|
    # If we find a new lower price, update the lowest price and its index
    if price < lowest
      lowest = price
      lowest_index = index
    end
    
    # Calculate profit made if sold stocks today
    profit = price - lowest

    # If the current profit is higher than the current max, update the max profit and store the indices
    if profit > max_profit
      max_profit = profit
      result = [lowest_index, lowest, index, price, max_profit]  # Store buy price, sell price, buy day index, sell day index
    end
  end

  if result.empty?
    puts "Profit cannot be made."
  else
    # Nicely formatted output
    puts "\nBest buy and sell days for maximum profit:"
    puts "Buy day (index): #{result[0]}, Buy price: $#{result[1]}"
    puts "Sell day (index): #{result[2]}, Sell price: $#{result[3]}"
    puts "Total profit: $#{result[4]}"
  end
end

# Repeatedly generates a random array of numbers and calls the stock picker method with them
def tester_method(num)
  index = 0
  until index == num.to_i do
    random_prices = Array.new(rand(5..25)) { rand(101) }
    puts "\nPassing random array of prices (each element is the price on a given day):"; print "#{random_prices}\n"
    stock_picker(random_prices)
    index += 1
  end
end

# Let the user choose the number of times to repeat random tests until they enter 0
user_input = ""
until user_input == "0"
  puts "\nHow many random sets of days would you like to test the stock picker method with?"
  user_input = gets.chomp
  
  # Validate user input, allow positive numbers and zero to exit
  if user_input.to_i.to_s == user_input && user_input.to_i >= 0
    tester_method(user_input.to_i)  # Convert to integer before passing it
  else
    puts "Please enter a valid number (greater than or equal to 0)."
  end
end