# fixed_length_encoder

A one-to-one mapping function between integers and fixed length strings, such that sequential integers
are mapped to non-sequntial strings.  In otherwords you can obfuscate user ids for use in urls.

* https://rubygems.org/gems/fixed_length_encoder
* http://github.com/brettwp/fixed_length_encoder

## How it works

A fixed length (default is 8) is specified and then for any integer a string is computed by first reversing
the binary digits and converting that number to a base 62 number using a shuffled alphabet of
0-9, a-z, A-Z.  For example:

    1 => kt4Cbnw8
    2 => aYmQp8ws 
    3 => DJ6K8oAt 
    4 => Ui97Wzw5
    5 => 9xsDwtAj 

## How to install

    sudo gem install fixed_length_encoder

## How to use

    require 'fixed_length_encoder'

    FixedLengthEncoder.encode(42)
    FixedLengthEncoder.decode('qJ5AVS7B')

    FixedLengthEncoder.encode(42, 3)
    FixedLengthEncoder.decode('q3u')

## Changing the length

    FixedLengthEncoder::MESSAGE_LENGTH = 10

## Changing the alphabet

    FixedLengthEncoder::ALPHABET = 'pontarelli'

    FixedLengthEncoder.encode(42)
    FixedLengthEncoder.decode('lelllpra')

    FixedLengthEncoder.encode(42, 3)
    FixedLengthEncoder.decode('tat')

# Extra

* Author  :: Brett Pontarelli <brett@paperyfrog.com>
* Website :: http://brett.pontarelli.com
