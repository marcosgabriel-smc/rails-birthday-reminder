Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: { sessions: 'users/sessions' }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  get '/contacts/auth/telegram/callback', to: 'contacts#telegram_login', as: :telegram_login

  resources :contacts

  post '/contacts/send_message', to: 'contacts#send_message', as: :send_message

end
