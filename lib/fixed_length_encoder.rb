module FixedLengthEncoder
  ALPHABET = 'cg1b723erwp5f8sv0hdmtzxa4juqik9lon6y'
  LENGTH = 8

  def self.encode(value, message_length = nil)
    message_length = LENGTH if message_length.nil?
    encoder = FixedLengthEncoder::Encoder.new(ALPHABET)
    encoder.encode(value, message_length)
  end

  def self.decode(message)
    encoder = FixedLengthEncoder::Encoder.new(ALPHABET)
    encoder.decode(message)
  end

  class Encoder
    def initialize(alphabet)
      @alphabet = alphabet
    end

    def setup(message_length)
      @message_length = message_length
      @max_message_value = (@alphabet.length)**message_length
      @max_bits = Math::log(@max_message_value, 2).floor
      @max_value = 2**@max_bits
    end

    def encode(value, message_length)
      raise ArgumentError, 'Cannot encode a non-integer.' unless value.is_a?(Integer)
      self.setup(message_length)
      raise ArgumentError, "Cannot encode #{value} in #{@message_length} characters" if value >= @max_value
      value = self.scramble_value(value, @max_bits)
      self.integer_to_string(@alphabet, value, @message_length)
    end

    def integer_to_string(alphabet, value, message_length)
      message = ''
      base = alphabet.length
      while (value > 0 || message.length < message_length)
        remainder = value % base
        message += alphabet[remainder]
        value = (value - remainder)/base
      end
      message
    end

    def decode(message)
      raise ArgumentError, 'Cannot decode a non-string.' unless message.is_a?(String)
      self.setup(message.length)
      value = self.string_to_integer(@alphabet, message)
      self.scramble_value(value, @max_bits)
    end

    def string_to_integer(alphabet, message)
      base = alphabet.length
      value = 0
      message.reverse.split('').each do |digit|
        index = alphabet.index(digit)
        raise ArgumentError, 'Cannot decode an invalid character (' + digit + ')' if index.nil?
        value = (value * base) + index
      end
      value
    end    

    def scramble_value(value, bits)
      binary = self.integer_to_string('10', value, bits).reverse
      self.string_to_integer('01', binary)
    end
  end
end
