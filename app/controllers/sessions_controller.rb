class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy


  def new
  end

  # def create
  #   # render plain: params.to_yaml and return
  #   user = User.find_by(email: params[:email])
  #   if user&.authenticate(params[:password])
  #     sign_in(user)
  #     remember(user) if params[:remember_me] == '1'
  #     flash[:warning] = "Welcome back, #{current_user.name_or_email}!"
  #     redirect_to root_path
  #   else
  #     flash.now[:warning] = 'Incorrect email and/or password!'
  #     render :new
  #   end
  # end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      do_sign_in user
      flash[:success] = t('.success', name: current_user.name_or_email)
      redirect_to root_path

    else
      flash.now[:warning] = t '.invalid_creds'
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = t '.success'
    redirect_to root_path
  end

  private

  def do_sign_in(user)
    sign_in user
    remember(user) if params[:remember_me] == '1'
  end
end