require 'generators/base'

# Splits input into sentences, each sentence is a sequence of characters
class SentenceGenerator < BaseCharacterGenerator
  def analyze(text)
    text.gsub(/[\r\n"]/, " ").split(/(?<=[.?!:])\B\s*/).each do |sentence|
      super(sentence)
    end
  end
end
