class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true
  validates :user_id, presence: true

  def set_user(id)
    self.user_id = id
  end
end
