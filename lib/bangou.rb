# encoding: UTF-8

class Bangou

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

	def self.integer_to_japanese_numerals int
		return "０" if int == 0
		digits = int.to_s.split(//).reverse
		digits.each_with_index.map do |digit, power|
			num   = digit.to_i
			text  = NUMERALS[num]
			base = 10 ** power
			if num > 0
				if power > 4
					text += BASES[base/10000]
					text += BASES[10000] unless digits.size > 1 and (digits[0..power - 1] & ("1".."9").to_a).size > 0
				else
					text += BASES[base]
				end
			end
			text = text[1..-1] if text =~ /^一.+/
			text
		end.reverse.join
	end

	def self.integer_to_japanese_text int
		return "ぜろ" if int == 0
		digits = int.to_s.split(//).reverse
		digits.each_with_index.map do |digit, power|
			num  = digit.to_i
			base = 10 ** power
			if value = EXCEPTIONS_TEXT[num * base]
				value
			else
				if num > 0
					if power > 4
						text = EXCEPTIONS_TEXT[num * base/10000] || NUMERALS_TEXT[num] + BASES_TEXT[base/10000]
						text += BASES_TEXT[10000] unless digits.size > 1 and (digits[0..power - 1] & ("1".."9").to_a).size > 0
					else
						text = NUMERALS_TEXT[num] + BASES_TEXT[base]
					end
				end
				text
			end
		end.reverse.join
	end

	def self.japanese_text_to_integer text
	end

	def self.japanese_text_to_japanese_numerals text
		integer_to_japanese_numerals(japanese_text_to_integer(text))
	end
end