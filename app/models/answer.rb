class Answer < ActiveRecord::Base
  belongs_to :question
  validates :body, presence: true, length: { in: 17..512 }
  validates_associated :question
end