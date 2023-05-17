require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to :question }
  it { is_expected.to belong_to :author }
  it { should have_many(:links) }

  it { is_expected.to validate_presence_of :body }

  it { should accept_nested_attributes_for :links }

end