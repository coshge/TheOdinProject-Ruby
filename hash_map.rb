class MyHashMap
  def initialize(initial_size = 16)
    @buckets = Array.new(initial_size)
    @size = 0
    @prime_number = 31
  end

  def hash(key)
    hash_code = 0
    key.each_char { |char| hash_code = @prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = hash(key) % @buckets.length
    @buckets[index] ||= []

    @buckets[index].each do |pair|
      if pair[0] == key
        pair[1] = value 
        return
      end
    end

    @buckets[index] << [key, value]
    @size += 1

    resize if @size > @buckets.length * 0.75
  end

  def get(key)
    index = hash(key) % @buckets.length
    bucket = @buckets[index]
    return nil unless bucket

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end
    nil
  end

  def has?(key)
    index = hash(key) % @buckets.length
    bucket = @buckets[index]
    return false unless bucket

    bucket.any? { |pair| pair[0] == key }
  end

  def remove(key)
    index = hash(key) % @buckets.length
    bucket = @buckets[index]
    return nil unless bucket

    bucket.each_with_index do |pair, i|
      if pair[0] == key
        @size -= 1
        return @buckets[index].delete_at(i)[1]
      end
    end
    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@buckets.length)
    @size = 0
  end

  def keys
    result = []
    @buckets.each do |bucket|
      next unless bucket
      bucket.each { |pair| result << pair[0] }
    end
    result
  end

  def values
    result = []
    @buckets.each do |bucket|
      next unless bucket
      bucket.each { |pair| result << pair[1] }
    end
    result
  end

  def entries
    result = []
    @buckets.each do |bucket|
      next unless bucket
      bucket.each { |pair| result << pair }
    end
    result
  end

  private

  def resize
    new_buckets = Array.new(@buckets.length * 2)
    
    @buckets.each do |bucket|
      next unless bucket
      bucket.each do |key, value|
        index = hash(key) % new_buckets.length
        new_buckets[index] ||= []
        new_buckets[index] << [key, value]
      end
    end

    @buckets = new_buckets
  end
end

map = MyHashMap.new
map.set("Carlos", "I am the old value.")
map.set("Carlos", "I am the new value.")
puts map.get("Carlos")
puts map.get("Alex")
puts map.has?("Carlos")
puts map.has?("Alex")
puts map.remove("Carlos") 
puts map.get("Carlos")
puts map.length
map.set("first_name", "John")
map.set("last_name", "Doe")
puts map.keys
puts map.values
puts map.entries
map.clear
puts map.length