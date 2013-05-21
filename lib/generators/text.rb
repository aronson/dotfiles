require 'generators/base'

# Splits input into sentences, each sentence is a sequence of words
# Generates chapters of random length
class TextGenerator < BaseWordGenerator
  def analyze(text)
    text.gsub(/[\r\n"]/, " ").split(/(?<=[.?!:])\B\s*/).each do |sentence|
      super(sentence)
    end
  end

  alias_method :next_sentence, :next

  def next_paragraph
    target_length = 50 + rand(500)
    para = next_sentence

    para << " #{next_sentence}" while para.length < target_length

    return para
  end

  def next_chapter
    target_length = 5000 + rand(1000)
    chapter = next_paragraph

    chapter << "\n\n#{next_paragraph}" while chapter.length < target_length

    return chapter
  end

  alias_method :next, :next_chapter
end
