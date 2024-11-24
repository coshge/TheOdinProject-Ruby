# Iterative Fib sequence
def fibs(num)
  return if num == 0
  return [0] if num == 1
  return [0,1] if num == 2

  sequence = [0,1,1]
  i = 2

  until sequence.length == num
    sequence << sequence[i] + sequence[i - 1]
    i += 1
  end

  sequence
end

# Recursive Fib sequence
def fibs_rec(num)
  return if num == 0
  return [0] if num == 1
  return [0,1] if num == 2

  sequence = fibs_rec(num - 1)
  sequence << sequence[-1] + (sequence[-2] || 0)
end 

def merge_sort(arr)
  # Base case
  return arr if arr.length <= 1

  # Split the array into two halves
  mid = arr.length / 2
  left = arr[0...mid]
  right = arr[mid..-1]

  # Recursively sort both halves
  left_sorted = merge_sort(left)
  right_sorted = merge_sort(right)

  merge(left_sorted, right_sorted)
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end

  sorted.concat(left)
  sorted.concat(right)

  sorted
end


# Test methods
print fibs(30)
puts
print fibs_rec(30)
puts
print merge_sort(Array.new(30) { rand(1..1000) })