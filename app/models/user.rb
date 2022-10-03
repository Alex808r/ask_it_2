class User < ApplicationRecord
  attr_accessor :old_password
  has_secure_password validations: false

  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 70 }

  validate :password_presence
  validate :password_complexity
  validate :correct_old_pasword, on: :update, if: -> { password.present? }

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true


  private



  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'Complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end

  def correct_old_password
    # return if authenticate(old_password) есть уязвимость
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add(:old_password, 'is incorrect')
  end



  validates :email, presence: true, uniqueness: true

end