# encoding: UTF-8

class Bangou

	def self.integer_to_japanese_numerals int
    convert_number(int, :numerals)
	end

	def self.integer_to_japanese_text int
    convert_number(int, :text)
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
    :text    => "ぜろ",
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
    return ZEROES[format] if int == 0
    digits = int.to_s.split(//).reverse
		digits.each_with_index.map do |digit, power|
			num  = digit.to_i
			base = 10 ** power
			if value = exceptions(num * base, format)
				value
			else
				if num > 0
					if power > 4
						text = exceptions(num * base/10000, format) || numerals(num, format) + bases(base/10000, format)
						text += bases(10000, format) unless digits.size > 1 and (digits[0..power - 1] & ("1".."9").to_a).size > 0
					else
						text = numerals(num, format) + bases(base, format)
					end
				end
        text = text[1..-1] if text =~ /^一.+/ and text.split(//).length > 1
				text
			end
		end.reverse.join
  end
end