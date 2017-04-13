class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num - 1] = true
  end

  def remove(num)
    @store[num - 1] = false
  end

  def include?(num)
    @store[num - 1]
  end

  private

  def is_valid?(num)
    num <= @store.length && num >= 0
  end

  def validate!(num)
    until @store.length == num
      @store << false
    end
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    arr = self[num]
    arr << num unless arr.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # p "count: #{@count}"
    # p "num_buckets: #{num_buckets}"
    resize! if num_buckets <= @count
    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  def count
    @count
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@count * 2) { [] }

    old_store.each do |arr|
      arr.each do |num|
        self[num] << num
      end
    end
  end
end
