Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options host: "localhost:3000"
  namespace :api, defaults: { format: :json } do
    namespace :v1  do
      resources :tasks, only: [:index, :create, :update, :destroy, :show]
      resources :tags, only: [:index, :create, :update, :show]
    end
  end
end
