class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy #para ele apagar os comentários quando article for excluido
  
end
