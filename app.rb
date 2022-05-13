require('sinatra')
require('sinatra/reloader')
require('./lib/words')
require('pry')
require('./lib/definition')
also_reload('lib/**/*.rb')

get('/') do
  @words = Word.all
  erb(:words)
end

get('/words') do
  @words = Word.all
  erb(:words)
end

get('/words/:id/edit') do
  @words = AWord.find(params[:id].to_i())
  erb(:edit_word)
end

get('/words/new') do
  erb(:new_word)
end

get('/words/:id') do
  @word = Word.find(params[:id].to_i())
  erb(:word)
end

post('/albums') do
  name = params[:name]
  id = params[:id]
  word = Word.new(name, id)
  word.save()
  @words = Word.all()
  erb(:words)
end

patch('/words/:id') do
  @word = Album.find(params[:id].to_i())
  @word.update(params[:name],params[:id])
  @words = Word.all
  erb(:words)
end

delete('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  @words = Word.all
  erb(:words)
end

