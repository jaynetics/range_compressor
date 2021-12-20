# RangeCompressor

[![Gem Version](https://badge.fury.io/rb/range_compressor.svg)](http://badge.fury.io/rb/range_compressor)
[![Build Status](https://github.com/jaynetics/range_compressor/workflows/tests/badge.svg)](https://github.com/jaynetics/range_compressor/actions)

A micro-gem that compresses enumerables into Ranges.

| Input                      | Output               |
|----------------------------|----------------------|
| [1, 2, 3, 4, 6, 8, 9, 10]  | [1..4, 6..6, 8..10]  |
| %w[a b c e g h]            | ['a'..'c', 'e'..'h'] |
| [1..5, 3..8]               | [1..8]               |
| [Set[1, 2], 3..6, [9, 10]] | [1..6, 9..10]        |

## Installation

`gem install range_compressor`

## Usage

```ruby
ranges = RangeCompressor.compress(some_enumerable)
```
