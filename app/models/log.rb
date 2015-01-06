class Log < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  validates :user_id, presence: true
  validates :path, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :view_count, presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  enum level: [:all_users, :bn, :bsc, :admin]
  enum status: [:hidden, :open, :locked]

  def increment_view
    self.increment!(:view_count, by = 1)
  end

  def decrement_view
    self.decrement!(:view_count, by = 1)
  end
end
