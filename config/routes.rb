Tudlr2::Application.routes.draw do

  match 'tagged' => 'jobs#tagged', :as => 'tagged'

  match '/home', to: 'static_pages#home'
  match '/about', to: 'static_pages#about'
  match '/myprojects', to: 'static_pages#myprojects'
  match '/myjobs', to: 'static_pages#myjobs'

  match '/bid', to: "static_pages#bid"
  match '/accept/:bid', to: "static_pages#accept"
  match '/complete/:bid', to: "static_pages#oncompletion"
  match '/reject/:bid', to: "static_pages#onrejection"
  match '/profile/:id', to: "static_pages#profile"

  resources :jobs


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#landingpage"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

end