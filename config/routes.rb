Rails.application.routes.draw do
  root 'main#dashboard'

  resources :apps, param: :app_name, only: %i{ index create destroy } do
    post :rename, on: :member
  end
  resources :containers, param: :app_name
end
