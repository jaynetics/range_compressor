require 'range_compressor/version'

module RangeCompressor
  module_function

  def compress(arg)
    # make contents flat, unique, and sorted
    sorted_set = to_sorted_set(arg)

    ranges = []
    previous = nil
    current_start = nil
    current_end = nil

    sorted_set.each do |object|
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

  SORTED_SET_CLASSES = %w[
    CharacterSet
    CharacterSet::Pure
    ImmutableSet
    RBTree
    SortedSet
  ].freeze

  def to_sorted_set(arg)
    if arg.nil?
      []
    elsif (arg.class.ancestors.map(&:to_s) & SORTED_SET_CLASSES).any?
      arg
    elsif arg.respond_to?(:each)
      hash = {}
      flatten(arg, hash)
      hash.keys.sort
    else
      raise(ArgumentError, 'value must be enumerable')
    end
  end

  def flatten(arg, hash)
    if arg.respond_to?(:each)
      if arg.instance_of?(Range) && (arg.begin.nil? || arg.end.nil?)
        raise ArgumentError, 'beginless and endless Ranges are not supported'
      end
      arg.each { |el| flatten(el, hash) }
    else
      hash[arg] = true
    end
  end
end
