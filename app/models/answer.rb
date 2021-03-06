class Answer < ActiveRecord::Base
  include Commentable
  include Votable

  belongs_to :question, touch: true
  belongs_to :user
  has_many :attachments, as: :attachable
  validates :body, presence: true, length: { in: 17..512 }
  validates :question, :user, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  scope :best, -> { where(best: true) }
  scope :solution_first, -> { order(best: :desc) }

  after_create :alert_subscribers

  def set_solution
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  private

  def alert_subscribers
    NewAnswerJob.perform_later question
  end
end
