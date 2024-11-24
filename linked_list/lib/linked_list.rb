class LinkedList
    def initialize()
      @head = nil
    end

    # Add to the end of the list
    def append(value)
      if @head.nil?
        @head = Node.new(value)
      else
        curr = @head
        until curr.next.nil?
          curr = curr.next
        end
        curr.next = Node.new(value)
      end
    end

    # Add to the front of the list
    def prepend(value)
      if @head.nil?
        @head = Node.new(value)
      else
        new_node = Node.new(value)
        new_node.next = @head
        @head = new_node
      end
    end

    # Insert given value at given index
    def insert_at(value, index)
      if index == 0
        new_node = Node.new(value)
        new_node.next_node = @head
        @head = new_node
        return
      end

      curr = @head
      prev = nil
      i = 0
      until curr.nil? || i == index
        return 'Index out of bounds' if index > self.size
        prev = curr
        curr = curr.next
        i += 1
      end
      new_node = Node.new(value)
      prev.next = new_node
      new_node.next = curr
    end

    def remove_at(index)
      if index == 0
        @head = @head.next
      else
        curr = @head.next
        prev = nil
        i = 1
        until i == index || curr.next.nil?
          prev = curr
          curr = curr.next
          i += 1
        end
        prev.next = prev.next.next
      end
    end

    # Return head node
    def head
      @head.value
    end

    # Return tail node
    def tail
      return @head if @head.next.nil?
      curr = @head
      until curr.next.nil?
        curr = curr.next
      end
      curr.value
    end

    # Return node at index passed
    def at(index)
      return @head if @head.next.nil?
      i = 0
      curr = @head
      until i == index || curr.next.nil?
        curr = curr.next
        i += 1
      end
      curr.value
    end

    # Remove last item from list
    def pop
      if @head.next.nil?
        @head = nil
      else
        curr = @head
        until curr.next.nil?
          prev = curr
          curr = curr.next
        end
        prev.next = nil
      end
    end

    # Check list for value
    def contains?(value)
      curr = @head
      until curr.next.nil?
        curr = curr.next
        return true if curr.value == value
      end
      false
    end

    # Find index of value
    def find(value)
      curr = @head
      i = 0
      until curr.next.nil?
        curr = curr.next
        i += 1
        return i if curr.value == value
      end
      nil
    end

    # Number of nodes in list
    def size
      return 0 if @head.nil?
      return 1 if @head.next.nil?

      curr = @head
      size = 1
      until curr.next.nil?
        curr = curr.next
        size += 1
      end
      size
    end

    # Print string representation of list
    def to_s
      curr = @head
      until curr.next.nil?
        print "( #{curr.value} ) -> "
        curr = curr.next
      end
      print "( #{curr.value} ) -> nil"
    end
end