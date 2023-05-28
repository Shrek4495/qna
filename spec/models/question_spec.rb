require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question, author: user) }
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }

  it { should have_many(:answers) }
  it { should have_many(:links) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'reputation' do

    let(:question) { build(:question, author: user) }

    it 'call Services::Reputation#calculate' do
      expect(ReputationJob).to receive(:perform_later).with(question)
      question.save!
    end

  end

end
