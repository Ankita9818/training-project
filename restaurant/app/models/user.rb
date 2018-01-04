class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  has_secure_password

  #validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: Email_Validation_Regex }, allow_blank: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  # callbacks
  before_create :confirmation_token
  after_save :send_email_verification_mail

  # assosciations
  has_many :comments, dependent: :destroy

  def activate_email
    self.update_attributes(email_confirmed: true, confirm_token: nil)
  end

  def send_email_verification_mail
    UserMailer.verify_email(self).deliver unless email_confirmed?
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes(reset_digest: User.digest(reset_token), reset_password_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.reset_password(self).deliver_now
  end

  def password_reset_expired?
    reset_password_sent_at < 2.hours.ago
  end

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  def forget_digest
    update_attribute(:remember_digest, nil)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def admin?
    role.eql? 'admin'
  end
end
