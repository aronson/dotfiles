require 'generators/base'

# Splits input into words, each word is a sequence of characters
class WordGenerator < BaseCharacterGenerator
  def analyze(text)
    words = text.split.map do |word|
      word.downcase!
      word.sub!(/'s$/, "")
      word.gsub!(/[[:^word:]]/, "")
      word
    end

    words.select! do |word|
      word.length >= @chain.order
    end

    words.each do |word|
      super(word)
    end

    return words
  end
end
