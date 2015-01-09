class User < ActiveRecord::Base
  has_many :topics
  has_many :logs
  has_many :comments

  attr_accessor :activation_token, :reset_token

  before_save :prepare
  before_create :create_activation_digest
  #before_validation :parameterize_name

  VALID_NAME_REGEX = /\A[[:alpha:]]+\z/i
  validates :name, presence: true, length: { maximum: 50, minimum: 2 },
                   format: { with: VALID_NAME_REGEX },
                   uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  enum level: [:user, :bn, :bsc, :admin]
  enum status: [:inactive, :active, :locked]

  def name
    self[:name].humanize
  end

  def bsc?
    self[:level] == 'bsc' || 'admin'
  end

  ### Authentication methods.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  ### Activate account.
  def activate
    update_columns(status: 1, activated_at: Time.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver!
  end

  ### Password reset methods.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver!
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    def prepare
      self.email = email.downcase
      self.name = name.downcase
      self.timezone = 'UTC'
      #self.name = self.original_name
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def parameterize_name
      self.original_name = self.name
      self.name = name.parameterize
    end
end
