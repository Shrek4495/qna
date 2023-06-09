require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add link
} do
  given(:user) { create(:user) }
  given(:gist_url) {'https://gist.github.com/Shrek4495/d7428423c6d31b427c4a6a4b1be8ae5c'}

  scenario 'User adds link when ask question' do

    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url

  end

end

