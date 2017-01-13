Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'

resources :categories

  get '/new_card', to: 'flash_cards#new_card'
  post '/new_card', to: 'flash_cards#create_card', as: 'create_card'

end
