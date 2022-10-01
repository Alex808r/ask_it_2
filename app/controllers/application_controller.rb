class ApplicationController < ActionController::Base
  include ErrorHandling
  include Pagy::Backend

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user, :user_signed_in?

  # Вынесли в Concerns
  # rescue_from ActiveRecord::RecordNotFound, with: :notfound
  #
  # private
  #
  # def notfound(exeption)
  #   logger.warn exeption
  #   render file: 'public/404.html', status: :not_found, layout: false
  # end
end
