Rails.application.routes.draw do
  root 'main#dashboard'

  resources :apps, param: :app_name
  resources :containers, param: :app_name
end
