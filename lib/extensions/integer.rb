
class Integer

	# Convert integer to Japanese kanji equivalent
	def to_j
		Bangou.integer_to_japanese_numerals(self)
	end

	# Convert integer to Sino-Japanese kana equivalent
	def to_jtext
		Bangou.integer_to_japanese_text(self)
	end
end