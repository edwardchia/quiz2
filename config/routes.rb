Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :edit]

  resource :session, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts do
    resources :reviews, only: [:create, :destroy]
  end
  root "posts#index"
end
