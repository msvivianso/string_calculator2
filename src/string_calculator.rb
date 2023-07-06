class StringCalculator
  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    ints = delimit_input(str)

    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0

    ints.filter { |i| i.to_i <= 1000 }.sum { |x| x.to_i }
  end

  def delimit_input(str)
    if str.include?('//')
      custom_delimiter(str)
    else
      default_delimiter(str)
    end
  end

  def custom_delimiter(str)
    head, tail = str.split('\n')
    delimiter = head.sub('//', '')
    ints = tail.split(delimiter)
  end

  def default_delimiter(str)
    ints = str.split(/[\\n,]/)
  end
end
