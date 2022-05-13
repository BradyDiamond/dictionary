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
  @words = Word.find(params[:id].to_i())
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
  name = params[:name]
  id = params[:id]
  word = Word.new(name, id)
  word.save()
  @words = Word.all()
  erb(:words)
end

patch('/words/:id') do
  @word = Word.find(params[:id].to_i())
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

post('words/:id/definitions') do
  @word = Word.find(params[:id].to_i())
  definition = Definition.new(params[:definition_body], @word.id, nil)
  definition.save()
  erb(:word)
end

get('/words/:id/definations/:defination_id') do
  @defination = Definition.find(params[:definition_id].to_i())
  erb(:defination)
end

patch('/words/:id/songs/:definition_id') do
  @word = Word.find(params[:id].to_i())
  defination = Defination.find(params[:definition_id].to_i())
  defination.update(params[:body], @word.id)
  erb(:word)
end

delete('/words/:id/definitions/definition_id') do
  definition = Definition.find(params[:definition_id].to_i())
  definition.delete
  @word = Word.find(params[:id].to_i())
  erb(:word)
end
