module Authentication
  extend ActiveSupport::Concern

  included do

    private

    def current_user
      user = session[:user_id].present? ? user_from_session : user_from_token

      @current_user ||= user&.decorate
    end

    def user_from_session
      User.find_by(id: session[:user_id])
    end

    def user_from_token
      user = User.find_by(id: cookies.encrypted[:user_id])
      token = cookies.encrypted[:remember_token]

      return unless user&.remember_token_authenticated?(token)

      sign_in user
      user
    end

    # def current_user
    #   if session[:user_id].present?
    #   @current_user ||= User.find(session[:user_id]).decorate
    #   elsif cookies.encrypted[:user_id].present?
    #     user = User.find(cookies.encrypted[:user_id])
    #     if user&.remember_token_authenticated?(cookies.encrypted[:remember_token])
    #       sign_in(user)
    #       @current_user ||= user.decorate
    #     end
    #   end
    # end

    def forget(user)
      user.forget_me
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def require_no_authentication
      return if !user_signed_in?
      flash[:warning] = 'You are already Signed In'
      redirect_to root_path
    end

    def require_authentication
      return if user_signed_in?
      flash[:warning] = 'You are not Signed In'
      redirect_to root_path
    end

    def remember(user)
      user.remember_me
      cookies.encrypted.permanent[:remember_token] = user.remember_token
      cookies.encrypted.permanent[:user_id] = user.id
    end

    helper_method :current_user, :user_signed_in?
  end
end