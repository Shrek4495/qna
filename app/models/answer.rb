class Answer < ApplicationRecord
  belongs_to :question, touch: true

  validates :body, presence: true
end
