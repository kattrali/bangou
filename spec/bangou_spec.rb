# encoding: UTF-8
$:.unshift(File.expand_path('../../lib',__FILE__))

require 'bangou.rb'

describe "Bangou" do
	describe "changes integers into Japanese numerals" do

		def compare integer, numeral
			Bangou.integer_to_japanese_numerals(integer).should.equal(numeral)
		end

		it "uses the correct bases for numbers" do
			compare(1,     "一")
			compare(10,    "十")
			compare(100,   "百")
			compare(1000,  "千")
			compare(10000, "万")
		end

		it "can parse digits in different places in a number, ignoring zeroes" do
			compare(7509,  "七千五百九")
			compare(81000, "八万千")
			compare(80001, "八万一")
			compare(80020, "八万二十")
		end

		it "can handle bases above 10^4" do
			compare(100000,    "十万")
			compare(1000000,   "百万")
			compare(50000000,  "五千万")
			compare(22000000,  "二千二百万")
		end
	end

	describe "changes integers into Japanese text" do
		def compare integer, text
			Bangou.integer_to_japanese_text(integer).should.equal(text)
		end

		it "can parse digits in different places in a number, ignoring zeroes" do
			compare(7509,  "ななせんごひゃくきゅう")
			compare(80000, "はちまん")
			compare(80001, "はちまんいち")
			compare(80020, "はちまんにじゅう")
		end

		it "uses the correct transformation for 3, 6, and 8" do
			compare(3, "さん")
			compare(6, "ろく")
			compare(8, "はち")

			compare(30, "さんじゅう")
			compare(60, "ろくじゅう")
			compare(80, "はちじゅう")

			compare(300, "さんびゃく")
			compare(600, "ろっぴゃく")
			compare(800, "はっぴゃく")

			compare(3000, "さんぜん")
			compare(6000, "ろくせん")
			compare(8000, "はっせん")

			compare(30000, "さんまん")
			compare(60000, "ろくまん")
			compare(80000, "はちまん")

			compare(300000, "さんじゅうまん")
			compare(600000, "ろくじゅうまん")
			compare(800000, "はちじゅうまん")

			compare(3000000, "さんびゃくまん")
			compare(6000000, "ろっぴゃくまん")
			compare(8000000, "はっぴゃくまん")
		end
	end
end