require('sinatra')
require('sinatra/reloader')
require('./lib/words')
require('pry')
also_reload('lib/**/*.rb')


class Word
  attr_reader :id, :name
  @@words = {}
  @@total_rows = 0

  def delete
    @@words.delete(self.id)
  end

  def update(name, id)
    @name = name
    @id = id || @@total_rows += 1
  end
 
  def initialize(name, id)
      @name = name
      @id = id || @@total_rows += 1
  end
 
  def self.all
    @@words.values()
  end

  def save
    @@words[self.id] = Word.new(self.name, self.id,)
  end
  
  def ==(word_to_compare)
    self.name() == word_to_compare.name() 
  end
  
  def self.clear
    @@words = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@words[id]
  end

  def definitions
    Definition.find_by_word(self.id)
  end
end
