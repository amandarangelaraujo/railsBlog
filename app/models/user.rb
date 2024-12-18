class User < ApplicationRecord
  # enum user_type: {commenter: 0, author: 1, admin: 2}
  has_secure_password
  validate :strong_password
  validates :password, confirmation: true # Valida a confirmação da senha
  validates :password_confirmation, presence: true, if: :password_digest_changed?
  has_many :comments,dependent: :destroy
  has_many :articles, foreign_key: :user_id, dependent: :destroy

  def self.email_in_use?(email)
    where(email: email.downcase).exists?
  end

  def self.strong_password?(password)
    return false if password.length < 12
    return false unless password.match?(/[a-z]/)
    return false unless password.match?(/[A-Z]/)
    return false unless password.match?(/[^a-zA-Z0-9]/)

    true
  end

  private

  def strong_password
    unless self.class.strong_password?(password)
      errors.add(:password, "Deve ter pelo menos 12 caracteres, incluindo uma letra maiúscula, uma minúscula e um caractere especial.")
    end
    # validates :email, presence: true, uniqueness: { case_sensitive: false }
  end
end
