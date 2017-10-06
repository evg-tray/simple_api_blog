class User < ApplicationRecord
  has_secure_password

  validates :nickname, :email, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :nickname, :email, uniqueness: { case_sensitive: false }
end
