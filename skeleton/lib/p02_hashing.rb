class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    m_hash = 0
    self.each_with_index { |e, i| m_hash = m_hash ^ (e.hash << i) }
    m_hash
  end
end

class String
  def hash
    m_hash = 0
    count = 0
    self.each_byte do |ascii|
      m_hash = m_hash ^ (ascii << count)
      count += 1
    end
    m_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    m_hash = 0
    self.each { |k, _| m_hash = m_hash ^ k.hash }
    m_hash
  end
end
