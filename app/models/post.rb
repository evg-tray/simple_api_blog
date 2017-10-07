class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :body, :author, :published_at, presence: true
  before_validation :set_published_at

  default_scope ->{ order(published_at: :desc) }

  private

  def set_published_at
    self.published_at = DateTime.now if published_at.nil?
  end
end
