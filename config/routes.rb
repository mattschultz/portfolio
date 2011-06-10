Portfolio::Application.routes.draw do
  root :to => "projects#index"
  
  devise_for :users

  resources :projects

  mount Rack::GridFS::Endpoint.new(:db => Mongoid.database), :at => "gridfs"
end
