class User < ApplicationRecord
  has_secure_password
  has_attached_file :avatar, styles: { thumb: '300x300#' }

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  validates :nickname, :email, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :nickname, :email, uniqueness: { case_sensitive: false }
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 3.megabytes
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
