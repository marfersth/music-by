Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :songs, shallow: true do
    # resources :artists, only: %i[create destory]
  end
  resources :albums, shallow: true do
    # resources :songs, only: %i[create destory]
  end
  resources :artists, shallow: true do
    # resources :albums, only: %i[create destory]
  end
end
