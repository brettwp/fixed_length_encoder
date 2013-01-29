require '../lib/fixed_length_encoder'

def c(number)
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

dmax = 0
average = 0
stddev = 0
neg = 0
one = 0
max = 36**8
encoder = FixedLengthEncoder::Encoder.new(FixedLengthEncoder::ALPHABET, FixedLengthEncoder::ENCODE_MAP, FixedLengthEncoder::DECODE_MAP)
iter = 10**7
puts '-'
(0..iter).each do |i|
  value = Random.rand(max - 2)
  e1 = encoder.string_to_integer(encoder.encode(value, 8))
  e2 = encoder.string_to_integer(encoder.encode(value+1, 8))
  delta = e1 - e2
  if (delta < 0)
    delta = -delta
    neg += 1
  end
  one += 1 if delta == 1
  dmax = delta if delta > dmax
  average += delta
  stddev += delta*delta
end
stddev = Math.sqrt((stddev - (average*average/iter))/iter)
average /= iter
puts 'Neg: ' + c(neg) + ' (' + (100.0*neg/iter).to_s + '%)'
puts 'One: ' + c(one) + ' (' + (100.0*one/iter).to_s + '%)'
puts 'Max: ' + c(dmax) + ' (36**8 = ' + c(max) + ')'
puts 'Avg: ' + c(average)
puts 'Std: ' + c(stddev)
