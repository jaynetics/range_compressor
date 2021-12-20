require 'set'

RSpec.describe RangeCompressor do
  it 'has a version number' do
    expect(RangeCompressor::VERSION).not_to be nil
  end

  describe '::compress' do
    it 'works with Arrays' do
      expect(RangeCompressor.compress([1, 2])).to eq [1..2]
    end

    it 'works with Sets' do
      expect(RangeCompressor.compress(Set[1, 2])).to eq [1..2]
    end

    it 'works with SortedSets' do
      expect(RangeCompressor.compress(SortedSet[1, 2])).to eq [1..2]
    end

    it 'works with unsorted Arrays' do
      expect(RangeCompressor.compress([3, 1, 2])).to eq [1..3]
    end

    it 'works with non-uniq Arrays' do
      expect(RangeCompressor.compress([1, 2, 2, 2])).to eq [1..2]
    end

    it 'works with Ranges' do
      expect(RangeCompressor.compress([1..5, 3..8])).to eq [1..8]
    end

    it 'returns an Array of Ranges, split based on contiguity' do
      expect(RangeCompressor.compress([]))
        .to eq []

      expect(RangeCompressor.compress([1, 2, 3]))
        .to eq [1..3]

      expect(RangeCompressor.compress([1, 3]))
        .to eq [1..1, 3..3]

      expect(RangeCompressor.compress([0, 2, 3, 4, 6, 8, 11, 12]))
        .to eq [
          0..0,
          2..4,
          6..6,
          8..8,
          11..12,
        ]
    end

    it 'returns an empty Array when given nil' do
      expect(RangeCompressor.compress(nil)).to eq []
    end

    it 'works correctly with mixed and nested inputs' do
      expect(RangeCompressor.compress([SortedSet[1, 2], 2..3, [[5, 6]]]))
        .to eq [1..3, 5..6]
    end

    it 'works with any contents responding to #next' do
      expect(RangeCompressor.compress(['a', 'b', 'c'])).to eq ['a'..'c']
      expect(RangeCompressor.compress([:a, :b, :c])).to eq [:a..:c]
    end

    it 'raises ArgumentError when given arguments that cannot be sorted' do
      expect { RangeCompressor.compress([1, :foo]) }.to raise_error(ArgumentError)
      expect { RangeCompressor.compress(Set[1, :foo]) }.to raise_error(ArgumentError)
      expect { RangeCompressor.compress(:foo) }.to raise_error(ArgumentError)
      if RUBY_VERSION.to_f >= 3.0
        expect { RangeCompressor.compress(1..) }.to raise_error(ArgumentError)
        expect { RangeCompressor.compress(..9) }.to raise_error(ArgumentError)
      end
    end
  end
end
