class StringCalculator
  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    ints = Delimiter.create(str).split

    ensure_positive_numbers(ints)

    filter_numbers_less_than_1000(ints).sum { |x| x.to_i }
  end

  private
  
  def filter_numbers_less_than_1000(ints)
    ints.filter { |i| i.to_i <= 1000 }
  end

  def ensure_positive_numbers(ints)
    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0
  end
end

class Delimiter
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def split
    ints = str.split(/[\\n,]/)
  end

  def self.create(str)
    if str.include?('//') == true
      CustomDelimiter.new(str)
    else
      Delimiter.new(str)
    end
  end
end

class CustomDelimiter < Delimiter
  def split
    head, tail = str.split('\n')
    delimiter = head.sub('//', '')
    ints = tail.split(delimiter)
  end
end
