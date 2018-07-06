require 'range_compressor/version'

module RangeCompressor
  module_function

  SORTED_SET_CLASSES = %w[
    CharacterSet
    CharacterSet::Pure
    ImmutableSet
    SortedSet
  ].freeze

  # Set#divide is very slow unfortunately, else it would be nice for this:
  # divide { |i, j| (i - j).abs == 1 }
  def compress(enum)
    if enum.class.ancestors.none? { |anc| SORTED_SET_CLASSES.include? anc.to_s }
      require 'set'
      enum = SortedSet.new(enum)
    end

    ranges = []
    previous = nil
    current_start = nil
    current_end = nil

    enum.each do |object|
      if previous.nil?
        current_start = object
      elsif previous.next != object
        # gap found, finalize previous range
        ranges << (current_start..current_end)
        current_start = object
      end
      current_end = object
      previous = object
    end

    # add final range
    ranges << (current_start..current_end) if current_start

    ranges
  end
end
