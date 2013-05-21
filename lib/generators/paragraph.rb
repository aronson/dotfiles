require 'generators/base'

# Splits input into paragraphs, each paragraph is a sequence of characters
class ParagraphGenerator < BaseCharacterGenerator
  def analyze(text)
    text.split(/\n\n|\r\r|\r\n\r\n/).each do |paragraph|
      super(paragraph)
    end
  end
end
