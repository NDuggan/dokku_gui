Rails.application.routes.draw do
  root 'main#dashboard'

  get :apps, controller: :main
  get :list, controller: :main
end
