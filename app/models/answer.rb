class Answer < ApplicationRecord
  belongs_to :question, touch: true
  belongs_to :author, class_name: 'User'

  validates :body, presence: true
end
