class Log < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  validates :user_id, presence: true
  validates :path, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :view_count, presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  scope :level, ->(user_level) { where('level <= ?', user_level) }

  enum level: [:normal_users, :trusted, :bsc, :admin]
  enum status: [:hidden, :open, :locked]

  def increment_view
    self.increment!(:view_count, by = 1)
  end

  def decrement_view
    self.decrement!(:view_count, by = 1)
  end

  def self.save_log(log_file, log)
    #File.open(Rails.root.join('public', 'logs', log.path), 'wt') do |file|
    #  file.write(log_file.tidy_bytes)
    #end
    File.open(Rails.root.join('public', 'logs', log.path), 'wt') do |file|
      IO.foreach(log_file.tempfile) do |line|
        file.write(line.force_encoding('iso-8859-1').encode('utf-8'))
      end
    end
  end

  def self.read_log(log)
    File.foreach(Rails.root.join('public', 'logs', log.path))
  end
end
