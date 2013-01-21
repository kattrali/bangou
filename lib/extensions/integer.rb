
class Integer

	def to_j
		Bangou.integer_to_japanese_numerals(self)
	end

	def to_jtext
		Bangou.integer_to_japanese_text(self)
	end
end