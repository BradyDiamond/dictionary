require 'rspec'
require 'words'
require 'definition'
require 'pry'

describe '#Definition' do

  before(:each) do
    Word.clear()
    Definition.clear()
    @word = Word.new("bunger", nil)
    @word.save()
  end

  describe('#==') do
    it("is the same Definition if it has the same attributes as another definition") do
      definition =  Definition.new("A stout beatle like creature", @word.id, nil)
      definition2 =  Definition.new("A stout beatle like creature", @word.id, nil)
      expect(definition).to(eq(definition2))
    end
  end

  describe('.all') do
    it("returns a list of all definitions") do
      definition = Definition.new("A stout beatle like creature", @word.id, nil)
      definition.save()
      definition2 = Definition.new("a stinky friend", @word.id, nil)
      definition2.save()
      expect(Definition.all).to(eq([definition, definition2]))
    end
  end

  describe('.clear') do
    it("clears all definitions") do
      definition = Definition.new("A stout beatle like creature", @word.id, nil)
      definition2 = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition2.save()
      Definition.clear()
      expect(Definition.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a definition") do
      definition = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition.save()
      expect(Definition.all).to(eq([definition]))
    end
  end

  describe('.find') do
    it("finds a defination by id") do
      definition = Definition.new("A stout beatle like creature", @word.id, nil)
      definition.save()
      definition2 = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition2.save()
      expect(Definition.find(definition.id)).to(eq(definition))
    end
  end

  describe('#update') do
    it("updates an definition by id") do
      definition = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition.save()
      definition.update("whole lotta gobbly gewk", @word.id)
      expect(definition.name).to(eq("whole lotta gobbly gewk"))
    end
  end

  describe('#delete') do
    it("deletes an definition by id") do
      definition = Definition.new("A stout beatle like creature", @word.id, nil)
      definition.save()
      definition2 = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition2.save()
      definition.delete()
      expect(Definition.all).to(eq([definition2]))
    end
  end

  describe('.find_by_word') do
    it("finds definitions for a word") do
      word2 = Word.new("bunger", nil)
      word2.save
      definition = Definition.new("purple ooze inside a gummy bear", @word.id, nil)
      definition.save()
      definition2 = Definition.new("A stout beatle like creature", word2.id , nil)
      definition2.save()
      expect(Definition.find_by_word(word2.id)).to(eq([definition2]))
    end
  end

  describe('#definitions') do
    it("returns a words definitions") do
      word = Word.new("Bunger", nil)
      word.save()
      definition = Definition.new("A stout beatle like creature", word.id, nil)
      definition.save()
      definition2 = Definition.new("a stinky friend", word.id, nil)
      definition2.save()
      expect(word.definitions).to(eq([definition, definition2]))
    end
  end

  describe('#word') do
    it("finds the word a definition belongs to") do
      definition = Definition.new("A stout beatle like creature", @word.id, nil)
      definition.save()
      expect(definition.word()).to(eq(@word))
    end
  end
end