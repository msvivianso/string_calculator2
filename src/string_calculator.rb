class StringCalculator
  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    ints = Delimiter.create(str).split

    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0

    ints.filter { |i| i.to_i <= 1000 }.sum { |x| x.to_i }
  end
end

class Delimiter
  def self.create(str)
    if str.include?('//') == true
      CustomDelimiter.new(str)
    else
      DefaultDelimiter.new(str)
    end
  end
end

class CustomDelimiter
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def split
    head, tail = str.split('\n')
    delimiter = head.sub('//', '')
    ints = tail.split(delimiter)
  end
end

class DefaultDelimiter
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def split
    ints = str.split(/[\\n,]/)
  end
end
