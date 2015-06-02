require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_least(6)  }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(23) }
  it { should have_many :answers }
end