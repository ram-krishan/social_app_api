Rails.application.routes.draw do
  get 'comments/create'

  resources :posts do
    member do
      post :like
    end
    resources :comments
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
