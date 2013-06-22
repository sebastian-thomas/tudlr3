Tudlr2::Application.routes.draw do


  match '/home', to: 'static_pages#home'
  match '/about', to: 'static_pages#about'
  match '/myprojects', to: 'static_pages#myprojects'
  match '/myjobs', to: 'static_pages#myjobs'

  match '/bid', to: "static_pages#bid"
  match '/accept/:bid', to: "static_pages#accept"

  resources :jobs


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

end