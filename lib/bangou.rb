# encoding: UTF-8

require 'extensions/integer.rb'

class Bangou
  class OutOfRangeException < Exception; end

  # Convert an Integer into Japanese numerals
  #
  # Example:
  #   Bangou.integer_to_japanese_numerals(89)
  #   # => "八十九"
  #
  # @param [Integer] the number to convert
  # @return [String] The Japanese numeric equivalent in kanji
  def self.integer_to_japanese_numerals int
    convert_number(int, :numeral)
  end

  # Convert an Integer into Sino-Japanese number
  # spelling in hiragana or katakana
  #
  # Examples:
  #   Bangou.integer_to_japanese_text(823)
  #   # => "はっぴゃくにじゅうさん"
  #   Bangou.integer_to_japanese_text(0)
  #   # => "ゼロ"
  #
  # @param [Integer] the number to convert
  # @return [String] The Sino-Japanese numeric equivalent in kana
  def self.integer_to_japanese_text int
    convert_number(int, :text)
  end

  # Detect whether a given number can be processed
  # by this class
  #
  # @return [Boolean]
  def self.in_range? int
    int >= 0 and int < 100000000
  end

  private

  NUMERAL_INDEX = 0
  TEXT_INDEX    = 1
  RANGE_ERROR_MESSAGE = "Bangou can only process numbers between 0 and 99,999,999"

  NUMERALS = {
		0 => ["",""],      1 => ["一","いち"], 2 => ["二","に"],
		3 => ["三","さん"], 4 => ["四","よん"], 5 => ["五","ご"],
		6 => ["六","ろく"], 7 => ["七","なな"], 8 => ["八","はち"],
		9 => ["九","きゅう"]
	}

  BASES = {
    1     => ["",""],
    10    => ["十","じゅう"],
    100   => ["百","ひゃく"],
    1000  => ["千","せん"],
    10000 => ["万","まん"]
  }

  EXCEPTIONS = {
    300  => [nil,"さんびゃく"],
    600  => [nil,"ろっぴゃく"],
    800  => [nil,"はっぴゃく"],
    3000 => [nil,"さんぜん"],
    8000 => [nil,"はっせん"]
  }

  ZEROES = {
    :text    => "ゼロ",
    :numeral => "０"
  }

  def self.index_for_format format
    format == :text ? TEXT_INDEX : NUMERAL_INDEX
  end

  def self.exceptions num, base, format
    hash_index = num * base
    EXCEPTIONS[hash_index][index_for_format(format)] if EXCEPTIONS[hash_index]
  end

  def self.numerals num, format
    NUMERALS[num][index_for_format(format)]
  end

  def self.bases num, format
    BASES[num][index_for_format(format)]
  end

  def self.convert_number int, format
    raise OutOfRangeException.new(RANGE_ERROR_MESSAGE) unless in_range?(int)
    return ZEROES[format] if int == 0

    digits = int.to_s.split(//).reverse

    digits.each_with_index.map do |digit, power|
      hide_base_from_value = has_more_digits_after_index?(digits, power)
      characters_for_digit_in_base(digit.to_i, 10 ** power, format, hide_base_from_value)
    end.reverse.join
  end

  def self.strip_leading_ones text
    text.sub(/^(一|いち)(.+)/,'\2')
  end

  def self.has_more_digits_after_index?(digits, index)
    digits.size > 1 and (digits[0..index - 1] & ("1".."9").to_a).size > 0
  end

  def self.characters_for_digit_in_base(num, base, format, hide_base_from_value)
    return "" if num == 0

    if text = exceptions(num, base, format)
      text
    elsif base <= 10000
      text = numerals(num, format) + bases(base, format)
    else
      text  = characters_for_digit_in_base(num, base/10000, format, hide_base_from_value)
      text += bases(10000, format) unless hide_base_from_value
    end
    strip_leading_ones(text)
  end
end