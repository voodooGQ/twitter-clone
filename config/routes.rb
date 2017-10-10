Rails.application.routes.draw do
  get 'chirps/new'

  get 'chirps/create'

  get 'chirps/update'

  root "static_pages#home"
end
