class Api::V1::Auth::UsersController < ApiApplicationController
  skip_before_action :authorize_request, only: [:create, :login]

  def create
    User.create!(user_params)
    json_response({ message: Message.account_created }, :created)
  end

  def login
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def upload_avatar
    current_user.update_attributes!(avatar: params[:avatar])
    json_response(avatar_url: current_user.avatar.url(:thumb))
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :password_confirmation)
  end

  def auth_params
    params.permit(:email, :password)
  end
end
