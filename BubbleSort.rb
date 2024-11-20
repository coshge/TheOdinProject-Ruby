##
## The Odin Project
## Project 4 - Bubble Sort Algorithm
##

# Sort array in ascending order using bubble sort algorithm
def bubble_sort(elements, run)
  swaps = 0 # Number f swaps performed on the current iteration of array
  index = 0   # Current index being iterated

  # Iterate through the array, swapping elements in pairs in ascending order
  while index < elements.length-1
    
    #Swap element with the one after it if its smaller
    if elements[index] > elements[index+1]
      temp = elements[index]
      elements[index] = elements[index+1]
      elements[index+1] = temp
      swaps += 1 # Increment swaps if one performed
    end
    index += 1
  end
  
  #Print number of swaps performed in this run and return the changed array
  puts "Numer of swaps in in run #{run}: #{swaps}"
  elements
end

# Repeatedly generates a random array of numbers and calls the bubble sort method with them
def tester_method()

  random_nums = Array.new(rand(25)) { rand(1001) } # Random integer array being sorted
  num_run = 1 # How many times have we gone through the array with bubble sort

  # Repeatedly pass random array until it is sorted
  until random_nums == random_nums.sort do

    puts "\n\nPassing array of integers to bubble sort:"; print "#{random_nums}\n"
    random_nums = bubble_sort(random_nums, num_run) # Update with result of current bubble sort
    num_run += 1 # Increment which number run we are through the array

    # Exit when sorted
    if random_nums == random_nums.sort
      puts "\nArray sorted after run #{num_run}, sorted array:\n"
      print random_nums
    else # Print state of array after iteration before passing it to bubble sort again
      puts "Current array after run #{num_run}:\n"
      print random_nums
    end
  end
end

# Allow user to repeated generate random arrays of numbers and sort them with buuble sort until they enter 'n'
user_input = ""
until user_input == "n"
  puts "\n\nDo you want to generate a random array and bubble sort it (Y/N)"
  user_input = gets.chomp.downcase
  if user_input == 'n'
    break
  else 
    tester_method()
  end
end
