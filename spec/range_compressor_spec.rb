require 'set'

RSpec.describe RangeCompressor do
  it 'has a version number' do
    expect(RangeCompressor::VERSION).not_to be nil
  end

  describe '::compress' do
    it 'takes any kind of sorted set' do
      expect { RangeCompressor.compress(SortedSet[1, 2]) }.not_to raise_error
    end

    it 'takes enumerables that can be cast to a sorted set' do
      expect { RangeCompressor.compress([1, 2]) }.not_to raise_error
      expect { RangeCompressor.compress(Set[1, 2]) }.not_to raise_error
    end

    it 'does not take arguments that cannot be cast to a sorted set' do
      expect { RangeCompressor.compress([1, :foo]) }.to raise_error(ArgumentError)
      expect { RangeCompressor.compress(Set[1, :foo]) }.to raise_error(ArgumentError)
      expect { RangeCompressor.compress(:foo) }.to raise_error(ArgumentError)
    end

    it 'returns an Array of Ranges, split based on contiguity' do
      expect(RangeCompressor.compress(SortedSet[]))
        .to eq []

      expect(RangeCompressor.compress(SortedSet[1, 2, 3]))
        .to eq [1..3]

      expect(RangeCompressor.compress(SortedSet[1, 3]))
        .to eq [1..1, 3..3]

      expect(RangeCompressor.compress(SortedSet[0, 2, 3, 4, 6, 8, 11, 12]))
        .to eq [
          0..0,
          2..4,
          6..6,
          8..8,
          11..12,
        ]
    end

    it 'works correctly with unsorted Arrays' do
      expect(RangeCompressor.compress([3, 1, 2])).to eq [1..3]
    end

    it 'works correctly with non-uniq Arrays' do
      expect(RangeCompressor.compress([1, 2, 2, 2])).to eq [1..2]
    end

    it 'works with any contents responding to #next' do
      expect(RangeCompressor.compress(['a', 'b', 'c'])).to eq ['a'..'c']
      expect(RangeCompressor.compress([:a, :b, :c])).to eq [:a..:c]
    end

    it 'returns an empty Array when given nil' do
      expect(RangeCompressor.compress(nil)).to eq []
    end
  end
end
