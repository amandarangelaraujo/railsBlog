class User < ApplicationRecord
  # enum user_type: {commenter: 0, author: 1, admin: 2}
  has_secure_password
  validates :password, confirmation: true # Valida a confirmação da senha
  validates :password_confirmation, presence: true, if: :password_digest_changed?
  has_many :comments
  has_many :articles, foreign_key: :user_id
end
