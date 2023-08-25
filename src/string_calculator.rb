class StringCalculator
  attr_reader :str

  def add(str)
    return 0 if str.empty?
    # ints.sum
    valid_ints(str).sum
  end

  private

  def valid_ints(str)
    @str = str
    ensure_positive_numbers
    filter_numbers_less_than_1000
  end

  def ints
    @ints ||= Delimiter.create(str).split.map { |str| str.to_i }
  end
  
  def filter_numbers_less_than_1000
    ints.filter { |i| i <= 1000 }
  end

  def ensure_positive_numbers
    negatives = ints.filter { |i| i < 0 }
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
