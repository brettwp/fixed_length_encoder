# fixed_length_encoder

A one-to-one mapping function between integers and fixed length strings, such that sequential integers
are mapped to non-sequential strings.  In other words you can obfuscate user ids for use in urls.

* https://rubygems.org/gems/fixed_length_encoder
* http://github.com/brettwp/fixed_length_encoder

## How it works

A fixed length (default is 8) is specified and then for any integer a string is computed by first reversing
the binary digits and converting that number to a base 36 number using a shuffled alphabet of
0-9, a-z.  For example:

    1 => otaarrtt 
    2 => laeottpr 
    3 => ronllleo 
    4 => rrnpnllr 
    5 => tnlreorn

Note that the maximum encodable value is not the same as the alphabet maximum.  For example the default 8 character
base 36 number is between 0 and 2,821,109,907,456 = `36**8`.  But, since the bit reversal needs to be symmetric we
limit the binary digits to `log(36**8, 2).floor`.  Thus, the maximum encodable value is 2,199,023,255,552 which you
can test by calling

    max_value = (2**Math::log(36**8, 2).floor)
    FixedLengthEncoder.encode(max_value - 1)
    FixedLengthEncoder.encode(max_value)

and noting that one raises an error and the other returns `cccccccc`.

## How to install

    sudo gem install fixed_length_encoder

## How to use

    require 'fixed_length_encoder'

    FixedLengthEncoder.encode(42)
    FixedLengthEncoder.decode('edluxu9d')

    FixedLengthEncoder.encode(42, 3)
    FixedLengthEncoder.decode('my0')

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
