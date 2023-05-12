require 'rails_helper'

feature 'User can show question with answers', %q{
 To find the answer i need
 As an authenticated or unauthenticated user
 I'd like to be able to view question with all answers
} do

  describe 'Authenticated user show a question with answers 'do
    given(:user) { create(:user) }
    given(:question) { create :question, author: user }


    background do
      sign_in(user)
      answers = create_list :answer, 1, question: question, author: user
      visit question_path(question)

    end
    scenario 'Show' do

      save_and_open_page
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_content answers.body
    end

  end
end
