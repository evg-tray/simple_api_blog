class Api::V1::PostsController < ApiApplicationController
  skip_before_action :authorize_request, only: [:show, :index]
  set_pagination_headers :posts, only: [:index]

  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  def index
    @posts = Post.all.page(params[:page]).per(params[:per_page])
    json_response(@posts)
  end

  def show
    @post = Post.find(params[:id])
    json_response(@post)
  end

  private

  def post_params
    params.permit(:title, :body, :published_at)
  end
end
