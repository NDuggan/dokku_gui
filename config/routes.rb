Rails.application.routes.draw do
  root 'main#dashboard'

  resources :apps, param: :app_name, only: %i{ index create destroy } do
    post :rename, on: :member
  end
  resources :containers, param: :app_name
  resources :plugins, param: :plugin_name do
    member do
      patch :enable
      patch :disable
    end
  end
end
