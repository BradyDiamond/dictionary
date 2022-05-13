require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word', {:type => :feature}) do
  it('creates a word and then goes to word page') do
    visit('/words')
    click_on('New word')
    fill_in('word_name', :with => 'Bunger')
    click_on('Add word')
    expect(page).to have_content('Bunger')
  end
end