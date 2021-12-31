require 'range_compressor/version'

module RangeCompressor
  module_function

  def compress(arg)
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
    elsif arg.class.ancestors.any? { |anc| SORTED_SET_CLASSES.include? anc.to_s }
      arg
    elsif arg.respond_to?(:each)
      hash = {}
      each_flattened(arg) { |el| hash[el] = true }
      hash.keys.sort
    else
      raise(ArgumentError, 'value must be enumerable')
    end
  end

  def each_flattened(arg, &block)
    if arg.class == Range && (arg.begin.nil? || arg.end.nil?)
      raise ArgumentError, 'beginless and endless Ranges are not supported'
    elsif arg.respond_to?(:each)
      arg.each { |el| each_flattened(el, &block) }
    else
      block.call(arg)
    end
  end
end
