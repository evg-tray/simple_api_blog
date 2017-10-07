class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :published_at, :author_nickname

  def author_nickname
    object.author.nickname
  end
end
