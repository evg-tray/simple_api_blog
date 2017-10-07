class User < ApplicationRecord
  has_secure_password

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  validates :nickname, :email, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :nickname, :email, uniqueness: { case_sensitive: false }
end
