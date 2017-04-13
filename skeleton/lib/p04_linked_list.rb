class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    curr_link = Link.new(key, val)
    curr_link.prev = @tail.prev
    @tail.prev.next = curr_link
    curr_link.next = @tail
    @tail.prev = curr_link
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
        break
      end
    end
  end

  def remove(key)
    link = get_link(key)
    link.remove
  end
  def each
    curr_link = @head.next
    while curr_link != @tail
      yield(curr_link)
      curr_link = curr_link.next
    end
  end

  private

  def get_link(key)
    self.each do |link|
      return link if link.key == key
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
