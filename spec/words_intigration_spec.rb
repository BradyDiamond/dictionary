require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word', {:type => :feature}) do
  it('creates a word and then goes to word page') do
    visit('/words')
    save_and_open_page
    click_on('New word')
    fill_in('word_name', :with => 'Bunger')
    click_on('Add word')
    expect(page).to have_content('Bunger')
  end
end
describe('create a definition path', {:type => :feature}) do
  it('creates a definition and then goes to the definition page') do
    word = Word.new("Yolo", nil)
    word.save
    visit("/wordss/#{word.id}")
    fill_in('def_body', :with => 'You only live once')
    click_on('Add a definition')
    expect(page).to have_content('You only live once')
  end
end