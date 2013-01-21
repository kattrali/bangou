# encoding: UTF-8
$:.unshift(File.expand_path('../../lib',__FILE__))

require 'bangou.rb'

describe "Integer additions" do
	it "adds Integer#to_j which is the kanji equivalent of a given integer" do
		89.to_j.should.equal "八十九"
		289.to_j.should.equal "二百八十九"
	end

	it "adds Integer#to_jtext which is the hiragana equivalent of a given integer" do
		89.to_jtext.should.equal "はちじゅうきゅう"
		289.to_jtext.should.equal "にひゃくはちじゅうきゅう"
	end
end