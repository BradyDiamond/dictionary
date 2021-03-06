require('sinatra')
require('sinatra/reloader')
require('./lib/words')
require('pry')
require('./lib/definition')
also_reload('lib/**/*.rb')

get('/') do
  @words = Word.all
  redirect to('/words')
end

get('/words') do
  @words = Word.all
  erb(:words)
end

get('/words/:id/edit') do
  @word = Word.find(params[:id].to_i())
  erb(:edit_word)
end

get('/words/new') do
  erb(:new_word)
end

get('/words/:id') do
  @word = Word.find(params[:id].to_i())
  erb(:word)
end

post('/words') do
  name = params[:word_name]
  id = params[:id]
  word = Word.new(name, nil)
  word.save()
  @words = Word.all()
  erb(:words)
end

patch('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.update(params[:word_name])
  erb(:word)
end

delete('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  @words = Word.all
  erb(:words)
end

post('/words/:id/definitions') do
  @word = Word.find(params[:id].to_i())
  @definition = Definition.new(params[:def_body], @word.id, nil)
  @definition.save()
  erb(:word)
end

get('/words/:id/definitions/:def_id') do
  @definition = Definition.find(params[:def_id].to_i())
  erb(:definition)
end

patch('/words/:id/definitions/:def_id') do
  @word = Word.find(params[:id].to_i())
  @defination = Definition.find(params[:def_id].to_i())
  @defination.update(params[:body], @word.id)
  erb(:word)
end

delete('/words/:id/definitions/:def_id') do
  @definition = Definition.find(params[:def_id].to_i())
  @definition.delete
  @word = Word.find(params[:id].to_i())
  erb(:word)
end
