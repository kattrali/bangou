# encoding: UTF-8

require 'extensions/integer.rb'

class Bangou
  class OutOfRangeException < Exception; end

	def self.integer_to_japanese_numerals int
    convert_number(int, :numeral)
	end

	def self.integer_to_japanese_text int
    convert_number(int, :text)
	end

  def self.in_range? int
    int >= 0 and int < 100000000
  end

  private

  NUMERALS = {
		0 => "",   1 => "一", 2 => "二",
		3 => "三", 4 => "四", 5 => "五",
		6 => "六", 7 => "七", 8 => "八",
		9 => "九"
	}

	NUMERALS_TEXT = {
		0 => "",    1 => "いち", 2 => "に",
		3 => "さん", 4 => "よん", 5 => "ご",
		6 => "ろく", 7 => "なな", 8 => "はち",
		9 => "きゅう"
	}

	BASES = {
		1    => "", 10 => "十", 100 => "百",
		1000 => "千", 10000 => "万"
	}

	BASES_TEXT = {
		1    => "", 10 => "じゅう", 100 => "ひゃく",
		1000 => "せん", 10000 => "まん"
	}

	EXCEPTIONS_TEXT = {
		300  => "さんびゃく", 600  => "ろっぴゃく",
		800  => "はっぴゃく",
		3000 => "さんぜん",   8000 => "はっせん"
	}

  EXCEPTIONS = {}

  ZEROES = {
    :text    => "ゼロ",
    :numeral => "０"
  }

  def self.exceptions num, format
    format == :text ? EXCEPTIONS_TEXT[num] : EXCEPTIONS[num]
  end

  def self.numerals num, format
    format == :text ? NUMERALS_TEXT[num] : NUMERALS[num]
  end

  def self.bases num, format
    format == :text ? BASES_TEXT[num] : BASES[num]
  end

  def self.convert_number int, format
    raise OutOfRangeException.new("Bangou can only process numbers between 0 and 99,999,999") unless in_range?(int)
    return ZEROES[format] if int == 0
    digits = int.to_s.split(//).reverse
    digits.each_with_index.map do |digit, power|
      hide_base_from_value = has_more_digits_before_index?(digits, power)
      characters_for_digit_in_base(digit.to_i, 10 ** power, format, hide_base_from_value)
    end.reverse.join
  end

  def self.strip_unneeded_characters text
    text = text[1..-1] if text =~ /^(一).+/
    text = text[2..-1] if text =~ /^(いち).+/
    text
  end

  def self.has_more_digits_before_index?(digits, index)
		digits.size > 1 and (digits[0..index - 1] & ("1".."9").to_a).size > 0
	end

  def self.characters_for_digit_in_base(num, base, format, hide_base_from_value)
    if text = exceptions(num * base, format)
      text
    else
      if num > 0 and base > 10000
        text = exceptions(num * base/10000, format) || characters_for_digit_in_base(num, base/10000, format, hide_base_from_value)
        text += bases(10000, format) unless hide_base_from_value
      elsif num > 0
        text = numerals(num, format) + bases(base, format)
      end
      strip_unneeded_characters(text)
    end
  end
end