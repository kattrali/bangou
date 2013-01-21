# 番号

A Ruby library for converting between positive integers and Sino-Japanese numbers or text.

[![Build Status](https://travis-ci.org/kattrali/bangou.png?branch=master)](undefined)

## Usage

```
require 'bangou'

Bangou.integer_to_japanese_numerals(2305)
# => "二千三百五"

Bangou.integer_to_japanese_text(2305)
# => "にせんさんびゃくご"
```

## Installation

`gem install bangou`

## Running Tests

番号 uses bacon for testing, runnable using `rake spec`.

## Contributing

Pull requests with tests accepted!

## Current Limitations

Only works on numbers between 0 and 99,999,999 (otherwise throwing an OutOfRangeException).