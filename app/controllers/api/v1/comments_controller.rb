class Api::V1::CommentsController < ApiApplicationController
  skip_before_action :authorize_request, only: [:show, :index]
  set_pagination_headers :comments, only: [:index]
  before_action :load_post

  def create
    @comment = @post.comments.create!(comment_params)
    json_response(@comment, :created)
  end

  def index
    @comments = @post.comments.page(params[:page]).per(params[:per_page])
    json_response(@comments)
  end

  def show
    @comments = @post.comments.find(params[:id])
    json_response(@comments)
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.permit(:body, :published_at).merge(author: current_user)
  end
end
