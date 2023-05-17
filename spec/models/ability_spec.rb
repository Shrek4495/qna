require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for quest' do

    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }

    it { should_not be_able_to  :manage, :all}

  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other_user) { create :user }
    let(:question) { create(:question, author: user) }
    let(:other_question) { create :question, author: other_user }
    let(:answer) { create(:answer, question: question, author: user) }
    let(:other_answer) { create :answer, question: question, author: other_user }


    it { is_expected.not_to be_able_to :manage, :all }
    it { is_expected.to be_able_to :read, :all }

    it { is_expected.to be_able_to :create, Question }
    it { is_expected.to be_able_to :create, Answer }
    it { is_expected.to be_able_to :update, question }
    it { is_expected.not_to be_able_to :update, other_question }
    it { is_expected.to be_able_to :destroy, question, user: user }
    it { is_expected.not_to be_able_to :destroy, other_question, user: user }
  end

end