require_relative('lib/node')
require_relative('lib/linked_list')

puts "Creating new list, appending 10 nodes, then prepending 10 values..."

# Put in random values
list = LinkedList.new
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.append(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))
list.prepend(rand(1..1000))

# Test List
puts "List of random values 1 to 1000"
list.to_s
puts "\nValue of list head: #{ list.head }"
test_val = list.head
puts "Value of list tail: #{ list.tail }"
list.contains?(test_val)
puts "Value at index 10: #{ list.at(10) }"
test_val_two = list.at(10)
puts "Index of value: #{ test_val_two }"
puts "Inserting value 500 at index 3..."
list.insert_at(500, 3)
puts "List after insertion:"
list.to_s
puts "\nRemoving value at index 7..."
list.remove_at(7)
puts "List after removal:"
list.to_s
puts "\nSize of list: #{ list.size }"
list.to_s
puts "\nPopping 5 values from end of list..."
list.pop
list.pop
list.pop
list.pop
list.pop
puts 'Updated list: '
list.to_s
print "\nUpdated list size: "; print list.size
