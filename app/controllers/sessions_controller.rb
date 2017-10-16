class SessionsController < ApplicationController

  def login_form
  end

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(uid: params[:uid])
      if user.nil?
        # If user is not found, make a new user using the users create method
          user = User.from_auth_hash(params[:provider], auth_hash)
        # redirect_to users_path, params: auth_hash, method: post
        if user.save
          session[:user_id] = user.id
          flash[:status] = :success
          flash[:result_text] = "Successfully logged in! Welcome back!"
        else
          flash[:status] = :failure
          flash[:result_text] = "Could not log in!"
          flash[:messages] = user.errors.messages
        end

      else
        flash[:status] = :failure
        flash[:result_text] = "Could not log in!"
        flash[:messages] = user.errors.messages
      end

      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash.now[:status] = :success
    flash.now[:result_text] = "Successfully logged out!"

    redirect_to root_path
  end


  #
  # def login
  #   username = params[:username]
  #   if username and user = User.find_by(username: username)
  #     session[:user_id] = user.id
  #     flash[:status] = :success
  #     flash[:result_text] = "Successfully logged in as existing user #{user.username}"
  #   else
  #     user = User.new(username: username)
  #     if user.save
  #       session[:user_id] = user.id
  #       flash[:status] = :success
  #       flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
  #     else
  #       flash.now[:status] = :failure
  #       flash.now[:result_text] = "Could not log in"
  #       flash.now[:messages] = user.errors.messages
  #       render "login_form", status: :bad_request
  #       return
  #     end
  #   end
  #   redirect_to root_path
  # end
  #
  # def logout
  #   session[:user_id] = nil
  #   flash[:status] = :success
  #   flash[:result_text] = "Successfully logged out"
  #   redirect_to root_path
  # end
end
