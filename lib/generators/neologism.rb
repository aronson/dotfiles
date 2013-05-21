require 'generators/word'
require 'set'

# Remembers all words in input, produces only words not in input
class NeologismGenerator < WordGenerator
  def initialize(n)
    @words = Set.new
    super
  end

  def analyze(text)
    @words += super(text)
  end

  def next
    begin
      candidate = super
    end while @words.member?(candidate)

    return candidate
  end

  def inspect
    "#<#{self.class.name} @chain=#{@chain}, Filter size: #{@words.size}>"
  end

  alias_method :to_s, :inspect
end
