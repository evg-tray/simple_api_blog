class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :body, presence: true
  before_validation :set_published_at

  default_scope ->{ order(published_at: :asc) }

  private

  def set_published_at
    self.published_at = DateTime.now if published_at.nil?
  end
end
