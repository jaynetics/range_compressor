# RangeCompressor

[![Gem Version](https://badge.fury.io/rb/range_compressor.svg)](http://badge.fury.io/rb/range_compressor)
[![Build Status](https://travis-ci.org/janosch-x/range_compressor.svg?branch=master)](https://travis-ci.org/janosch-x/range_compressor)

A micro-gem that turns this:

```ruby
[1, 2, 3, 4, 6, 8, 9, 10]
```

into this:

```ruby
[1..4, 6..6, 8..10]
```

## Installation

`gem install range_compressor`

## Usage

```ruby
ranges = RangeCompressor.compress(some_enumerable)
```
