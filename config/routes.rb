Rails.application.routes.draw do
  
  devise_for :users

  scope "api" do
  	resources :accounts
  	resources :currencies
  end

  root to: "pages#home"
  get  '/sign_up', to: 'users#sign_up'
  get '/log_in', to: 'users#log_in'
  get 'pages/accounts'
  get 'pages/new_account'

end
