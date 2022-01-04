class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      @store[num.hash % num_buckets] << num.hash
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def remove(num)
    if self.include?(num)
      @store[num.hash % num_buckets].delete(num.hash)
      @count -= 1
    end
  end

  def include?(num)
    @store[num.hash % num_buckets].index(num.hash) != nil
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
