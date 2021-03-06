require_relative '../feature_helper'

feature 'Delete answers', '
  In order to keep only actual answers
  As an authenticated user and author
  I can delete my answer
' do
  given(:user) { create(:user) }
  given(:answer) { create(:answer) }

  scenario 'author can delete own question on show', js: true do
    sign_in(answer.user)
    visit question_path(answer.question)
    within "#answer_#{answer.id}" do
      click_on 'delete'
    end
    expect(page).to have_content 'Answer destroyed successfully!'
  end

  scenario 'non-author can not delete question on show' do
    sign_in(user)
    visit question_path(answer.question)
    within "#answer_#{answer.id}" do
      expect(page).to_not have_link('delete')
    end
  end

  scenario 'non authenticated user question on show' do
    visit question_path(answer.question)
    within "#answer_#{answer.id}" do
      expect(page).to_not have_link('delete')
    end
  end
end
