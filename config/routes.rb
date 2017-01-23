Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#index'
  resources :categories
  resources :cards

  get 'new_review_session', to: 'cards#new_review_session', as: 'new_review_session'


end
