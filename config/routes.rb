require 'sidekiq/web'
class AdminConstraint
  def matches?(request)
    # debugger
    user_id = request.session[:user_id] || request.cookie_jar.encrypted[:user_id]

    User.find_by(id: user_id)&.admin_role?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new

  concern :commentable do
    resources :comments, only: %i[create destroy]
  end

  namespace :api do
    resources :tags, only: :index
  end

  scope'(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root 'pages#index'
    # get '/questions', to: 'questions#index'
    # get '/questions/new', to: 'questions#new'
    # post '/questions', to: 'questions#create'
    # get '/questions/:id/edit', to: 'questions#edit'

    resources :questions, concerns: :commentable do
      resources :answers, except: %i[new show]
    end

    resource :password_reset, only: %i[new create edit update]

    resources :answers, except: %i[new show], concerns: :commentable

    resources :users, only: %i[new create edit update]

    resource :session, only: %i[new create destroy]

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
    end
  end
end
