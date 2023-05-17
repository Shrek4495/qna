class Answer < ApplicationRecord
  belongs_to :question, touch: true
  belongs_to :author, class_name: 'User'
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank
  validates :body, presence: true
end
