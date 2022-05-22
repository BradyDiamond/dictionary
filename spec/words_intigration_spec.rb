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
    click_on('Go!')
    expect(page).to have_content('Bunger')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a definition and then goes to the definition page') do
    word = Word.new("Yolo", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('def_body', :with => 'You only live once')
    click_on('Add a definition')
    expect(page).to have_content('You only live once')
  end
end

describe('updates a word ', {:type => :feature}) do
  it('creates a word and then updates the word') do
    visit('/words')
    save_and_open_page
    click_on('New word')
    fill_in('word_name', :with => 'bing')
    click_on('Go!')
    click_on('bing')
    click_on('Edit word')
    fill_in('word_name', :with => 'boing')
    click_on('Update')
    expect(page).to have_content('boing')
  end
end


describe('updates a definition ', {:type => :feature}) do
  it('creates a definition and then updates to the definition') do
    word = Word.new("Yolo", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('def_body', :with => 'You only live once')
    click_on('Add a definition')
    click_link('You only live once')
    fill_in('body', :with => 'You only live once, my dude')
    click_on('Change word definition')
    expect(page).to have_content('You only live once, my dude')
  end
end

describe('deletes a word', {:type => :feature}) do
  it('creates a word and then deletes it') do
    visit('/words')
    save_and_open_page
    click_on('New word')
    fill_in('word_name', :with => 'boop')
    click_on('Go!')
    click_on('boop')
    click_on('Edit word')
    click_on('Delete word')
    expect(page).should have_no_content('boop')
  end
end

describe('deletes a definition ', {:type => :feature}) do
  it('creates a definition and then deletes the definition') do
    word = Word.new("Yolo", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('def_body', :with => 'You only live once')
    click_on('Add a definition')
    click_link('You only live once')
    click_on('Delete definition')
    expect(page).should have_no_content('You only live once')
  end
end
