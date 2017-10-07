class Api::V1::Auth::UsersController < ApplicationController
  skip_before_action :authorize_request

  def create
    User.create!(user_params)
    json_response({ message: Message.account_created }, :created)
  end

  def login
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :password_confirmation)
  end

  def auth_params
    params.permit(:email, :password)
  end
end
