class User < ApplicationRecord
  # enum user_type: {commenter: 0, author: 1, admin: 2}
  has_many :comments
  has_many :articles, foreign_key: :user_id
  has_secure_password
end
