class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def create
    # self.from_auth_hash(params[:provider], auth_hash)
    #
    # if user.save
    #   session[:user_id] = user.id
    #   flash[:status] = :success
    #   flash[:message] = "Successfully logged in! Welcome back!"
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "Could not log in!"
    #   flash[:details] = user.errors.messages
    # end
    #
    # redirect_to root_path
  end
end
