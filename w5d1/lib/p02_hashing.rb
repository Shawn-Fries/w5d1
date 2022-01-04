class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.join("").to_i.hash
  end
end

class String
  def hash
    result = []
    self.each_char {|char| result << char.ord}
    result.join('').to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.to_s.hash
  end
end
