Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # "guest" session
  resources :chat_sessions

  # "Operatoristrator" session
  get '/operator' => 'operator#index'
  namespace :operator do
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :chat_sessions, only: %i[create show destroy] do
      member { post :disconnect }
    end
  end

  # assume all visitors are guests
  root 'chat_sessions#new'
end
