Rails.application.routes.draw do
  scope'(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root 'pages#index'
    # get '/questions', to: 'questions#index'
    # get '/questions/new', to: 'questions#new'
    # post '/questions', to: 'questions#create'
    # get '/questions/:id/edit', to: 'questions#edit'

    resources :questions, only: %i[index new edit create update destroy show] do

      resources :comments, only: %i[create destroy]
      resources :answers, except: %i[new show]
    end

    resources :answers, except: %i[new show] do
      resources :comments, only: %i[create destroy]
    end

    resources :users, only: %i[new create edit update]

    resource :session, only: %i[new create destroy]

    namespace :admin do
      resources :users, only: %i[index create]
    end
  end
end
