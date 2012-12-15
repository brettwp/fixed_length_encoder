require 'fixed_length_encoder'

def suppress_warnings
  original_verbosity = $VERBOSE
  $VERBOSE = nil
  result = yield
  $VERBOSE = original_verbosity
  return result
end

describe FixedLengthEncoder do
  describe 'Invalid encodings' do
    before (:each) do
      suppress_warnings do
        @origianl = FixedLengthEncoder::ALPHABET
        FixedLengthEncoder::ALPHABET = '0123456789'
      end
    end

    after (:each) do
      suppress_warnings do
        FixedLengthEncoder::ALPHABET = @origianl
      end
    end

    it 'should error on non-integers' do
      expect { FixedLengthEncoder.encode('ERROR') }.to raise_error(ArgumentError)
    end

    it 'shouldn\'t encode values too big for message length' do
      expect { FixedLengthEncoder.encode(64, 2) }.to raise_error(ArgumentError)
    end

    it 'should error for non-strings' do
      expect { FixedLengthEncoder.decode(0) }.to raise_error(ArgumentError)
    end

    it 'should error for bad characgters' do
      expect { FixedLengthEncoder.decode('^') }.to raise_error(ArgumentError)
    end
  end

  describe 'Valid encodings' do
    before (:each) do
      suppress_warnings do
        @origianl = FixedLengthEncoder::ALPHABET
        FixedLengthEncoder::ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
      end
    end

    after (:each) do
      suppress_warnings do
        FixedLengthEncoder::ALPHABET = @origianl
      end
    end

    it 'should be reversible' do
      value = 99999
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end

    it 'should be reversible for the max value' do
      value = (2**Math::log(62**8, 2).floor)-1
      message = FixedLengthEncoder.encode(value)
      message.should eq('00000000')
      FixedLengthEncoder.decode(message).should eq(value)
    end
  end
end
