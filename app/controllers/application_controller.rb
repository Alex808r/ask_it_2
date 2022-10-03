class ApplicationController < ActionController::Base
  include ErrorHandling
  include Pagy::Backend
  include Authentication


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
