# fixed_length_encoder

A one-to-one mapping function between integers and fixed length strings, such that sequential
integers are mapped to non-sequential strings.  In other words you can obfuscate user ids for use
in urls.

* https://rubygems.org/gems/fixed_length_encoder
* http://github.com/brettwp/fixed_length_encoder

## How it works

### Encoding

Converts an integer value to a string of fixed length (default is 8).  As of `1.2` the maximum encodable value is the same as the alphabet maximum.  For example the default 36 character alphabet and 8 character fixed length can encoded numbers between 0 and 2,821,109,907,455 = `36**8 - 1`.

### Decoding

Given a valid string returns the decoded number.  Note that the two operations are reversible and
adjacent values are unlikely to return adjacent strings (See Stats section below).  For example, using the default configuration:

    FixedLengthEncoder.decode(FixedLengthEncoder.encode(100)) == 100
    FixedLengthEncoder.encode(100) == 'ycxk2ntw'
    FixedLengthEncoder.encode(101) == 'd8gxk24x'

## How to install

    sudo gem install fixed_length_encoder

## How to use

    require 'fixed_length_encoder'

    FixedLengthEncoder.encode(100)
    FixedLengthEncoder.decode('ycxk2ntw')

    FixedLengthEncoder.encode(42, 3)
    FixedLengthEncoder.decode('5c4')

## Changing the length

    FixedLengthEncoder::MESSAGE_LENGTH = 10

## Changing the alphabet and encoding

The `ALPHABET`, `ENCODE_MAP` and `DECODE_MAP` must all work together.  The two maps must also be
reversible.  For example, for an alphabet of 62 characters you will need to build two maps of
length `62**2 - 1` such that `DECODE_MAP[ENCODE_MAP[x]] == x`.  One such way to do this would be:

    max = 62*62 - 1
    ENCODE_MAP = (0..max).to_a.shuffle
    DECODE_MAP = []
    (0..max).each { |i| DECODE_MAP[ENCODE_MAP[i]] = i }

Then, hard code these results into your application.  You will have three lines much like the lines
that define the default `ALPHABET`, `ENCODE_MAP` and `DECODE_MAP` in the `FixedLengthEncoded`:

    FixedLengthEncoder::ALPHABET = 'abcdefg'
    FixedLengthEncoder::ENCODE_MAP = [19, 22, 25, 44, 17, 21, 33, 48, 39, 0, 16, 20, 29, 40, 43, 23, 3, 41, 12, 35, 7, 14, 10, 32, 46, 38, 9, 11, 27, 31, 26, 18, 34, 24, 4, 42, 47, 5, 1, 36, 13, 37, 30, 15, 45, 2, 8, 28, 6]
    FixedLengthEncoder::DECODE_MAP = [9, 38, 45, 16, 34, 37, 48, 20, 46, 26, 22, 27, 18, 40, 21, 43, 10, 4, 31, 0, 11, 5, 1, 15, 33, 2, 30, 28, 47, 12, 42, 29, 23, 6, 32, 19, 39, 41, 25, 8, 13, 17, 35, 14, 3, 44, 24, 36, 7]

# Stats

Running ruby `stats\test.rb` a random sample of 10M values were encoded along with
`value + 1`.  The delta between the two strings were compared (as base 36 numbers) and the results
are summarized below:

     Negative deltas:         4,952,221 (49.52221%)
    Delta equals one:            30,830 (0.3083%)
       Maximum Delta: 2,807,409,875,961 (36**8 = 2,821,109,907,456)
       Average Delta:   789,874,810,124
             Std Dev:   697,298,809,493

* Author  :: Brett Pontarelli <brett@paperyfrog.com>
* Website :: http://brett.pontarelli.com
