require 'rspec'
require 'words'

describe ('#Word') do
  before(:each) do
    Word.clear()
  end  
  describe('.all') do
    it("returns an empty array when there are no words") do  
      expect(Word.all).to(eq([]))
    end
  end 

  describe('#save') do
    it("saves a word ") do
      word1 = Word.new("bunger", nil)
      word1.save()
      word2 = Word.new('chumbo', nil)
      word2.save()
      expect(Word.all).to(eq([word1,word2]))
      end
  end 
  describe('#==') do
    it("is the same word if it has the same attributes as another word") do
      word1 = Word.new("bunger", nil)
      word2 = Word.new("bunger", nil)
      expect(word1).to(eq(word2))
    end
  end

  describe('.clear') do
    it("clears all words") do
      word1 = Word.new("bunger", nil)
      word1.save()
      word2 =Word.new('chumbo', nil)
      word2.save()
      Word.clear()
      expect(Word.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an word by id") do
      word1 = Word.new("bunger", nil)
      word1.save()
      word2 = Word.new('chumbo', nil)
      word2.save()
      expect(Word.find(word1.id)).to(eq(word1))
    end
  end

  describe('#update') do
    it("updates a word by id") do
      word1 = Word.new("bunger", nil)
      word1.save()
      word1.update('chumbo', nil)
      expect(word1.name).to(eq('chumbo'))
    end
  end

  describe('#delete') do
    it("deletes an word by id") do
      word1 = Word.new("bunger", nil)
      word1.save()
      word2 = Word.new('chumbo', nil)
      word2.save()
      word1.delete()
      expect(Word.all).to(eq([word2]))
    end
  end
end
