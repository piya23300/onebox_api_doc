Rails.application.routes.draw do

  mount OneboxApiDoc::Engine => "/onebox_api_doc"

  resources :products, only: [:index, :create, :show, :update, :destroy]
  resources :users, only: [:show, :update]
end
