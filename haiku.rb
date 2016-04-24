require "ruby_rhymes"
require 'pry'

class HaikuBot
  attr_reader :word1, :word2, :first_line, :second_line,
              :third_line, :dictionary, :staging

  def initialize(word1, word2)
    @word1 = word1
    @word2 = word2
    @dictionary ||= File.read('/usr/share/dict/words').split("\n")
    @first_line ||= create_first_line
    @second_line ||= create_second_line
    @third_line ||= create_third_line
  end

  def find_syllable(num)
    x = dictionary.shuffle
    x.find{|word| word.to_phrase.syllables == num}
  end

  def create_first_line
    words = []
    words << word1
    target_count = 5 - words.join.to_phrase.syllables
    words << find_syllable(target_count)
    words.shuffle.join(" ")
  end

  def create_second_line
    words = []
    words << find_syllable(3)
    words << find_syllable(2)
    words << find_syllable(2)
    words.shuffle.join(" ")
  end

  def create_third_line
    words = []
    words << word2
    target_count = 5 - words.join.to_phrase.syllables
    if target_count == 4
      words << find_syllable(2)
      words << find_syllable(2)
    elsif target_count == 3
      words << find_syllable(3)
    elsif target_count == 2
      words << find_syllable(2)
    elsif target_count == 1
      words << find_syllable(1)
    end
    words.shuffle.join(" ")
  end


end

haiku = HaikuBot.new("hello", "what")
p haiku.first_line
p haiku.second_line
p haiku.third_line
