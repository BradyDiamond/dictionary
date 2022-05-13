require('sinatra')
require('sinatra/reloader')
require('./lib/words')
require('pry')
also_reload('lib/**/*.rb')

class Definition
  attr_reader :id
  attr_accessor :name, :word_id

  @@definitions = {}
  @@total_rows = 0

  def initialize(body, word_id, id)
    @body = body
    @word_id = word_id
    @id = id || @@total_rows += 1
  end

  def self.find_by_word(word_id)
    definitions = []
    @@definitions.values.each do |definition|
      if definition.word_id == word_id
        definition.push(word)
      end
    end
    definitions
  end

  def word
    Word.find(self.word_id)
  end

  def ==(definition_to_compare)
    (self.body() == definition_to_compare.body()) && (self.word_id() == definition_to_compare.word_id())
  end

  def self.all
    @@definitions.values
  end

  def save
    @@definition[self.id] = Definition.new(self.body, self.word_id, self.id)
  end

  def self.find(id)
    @@definitions[id]
  end

  def update(name, word_id)
    self.body = name
    self.word_id = word_id
    @@definitions[self.id] = Song.new(self.body, self.album_id, self.id)
  end

  def delete
    @@definitions.delete(self.id)
  end

  def self.clear
    @@definitions = {}
  end
end