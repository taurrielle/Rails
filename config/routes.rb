Rails.application.routes.draw do

  devise_for :users

  scope "api" do
  	resources :accounts
  	resources :currencies
    resources :transactions
  end


  namespace :api, :defaults => { :format => :json } do
    resources :users, :as => 'user' do
      post :create
    end
  end


  root to: "pages#home"
  get  '/sign_up', to: 'users#sign_up'
  get '/log_in', to: 'users#log_in'
  get 'pages/accounts'
  get 'pages/transactions'

end
