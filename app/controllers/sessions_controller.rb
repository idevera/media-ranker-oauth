class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:login]

  def index
    @user = User.find(session[:user_id])
  end

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']

      user = User.find_by(uid: auth_hash['uid'])

      if user == nil

        # If user is not found, make a new user using the users create method
        user = User.from_auth_hash(params[:provider], auth_hash)

        if user.save!
          session[:user_id] = user.id
          flash[:status] = :success
          flash[:result_text] = "Successfully logged in as #{user.username}"
        else
          flash[:status] = :failure
          flash[:result_text] = "Whoops! There was a problem with you request!"
          flash[:messages] = user.errors.messages
        end

      # Logic if you have already logged in previously!!!! Based on your uid
      else
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Welcome back #{user.username}!"
        flash[:messages] = user.errors.messages
      end

      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out!"

    redirect_to root_path
  end

end
