class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max and num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num unless self.include?(num)
  end

  def remove(num)
    @store[num].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].index(num) != nil
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
    unless self.include?(num)
      @store[num % num_buckets] << num
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def remove(num)
    if self.include?(num)
      @store[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].index(num) != nil
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
      new_store = Array.new(num_buckets * 2) { Array.new }
      @store.each_index do |bucket|
        new_store[bucket] << @store[bucket].select {|ele| (ele / num_buckets).even?}[0]
        new_store[bucket + num_buckets] << @store[bucket].select {|ele| (ele / num_buckets).odd?}[0]
      end
      @store = new_store
  end
end

a = IntSet.new(5)
a.insert(5)
p a