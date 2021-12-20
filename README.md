# RangeCompressor

[![Gem Version](https://badge.fury.io/rb/range_compressor.svg)](http://badge.fury.io/rb/range_compressor)
[![Build Status](https://github.com/jaynetics/range_compressor/workflows/tests/badge.svg)](https://github.com/jaynetics/range_compressor/actions)

A micro-gem that turns this:

```ruby
[1, 2, 3, 4, 6, 8, 9, 10]
```

into this:

```ruby
[1..4, 6..6, 8..10]
```

(or `%w[a b c d e g h i]` into `['a'..'e', 'g'..'i']`, or ... )

## Installation

`gem install range_compressor`

## Usage

```ruby
ranges = RangeCompressor.compress(some_enumerable)
```
