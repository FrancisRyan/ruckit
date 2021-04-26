Rails.application.routes.draw do
 
  get 'message/create'
  root 'pages#home'
  
  get '/dashboard', to: 'users#dashboard'
  get '/users/:id', to: 'users#show', as: 'users'
  get '/creating_challenges', to: 'challenges#creating_challenges'
  get '/challenging_challenges', to: 'challenges#challenging_challenges'
  get '/challenges/:id', to: 'challenges#show', as: "challenge_detail"
  
  get '/all_requests', to: 'requests#list'
  get '/request_offers/:id', to: 'requests#offers', as: 'request_offers'
  get '/my_offers', to: 'requests#my_offers'
  get '/search', to: 'pages#search'
  get '/calendar', to: 'pages#calendar'
  get '/fixtures/:id/checkout/:detailing_type', to: 'fixtures#checkout', as: 'checkout'
  get '/conversations', to: 'conversations#list', as: "conversations"
  get '/conversations/:id', to: 'conversations#show', as: "conversation_detail"
 
 
 
  post '/users/edit', to: 'users#update'
  post '/offers', to: 'offers#create'
  post '/reviews', to: 'reviews#create'
  post 'messages', to: 'messages#create'
  post '/comments', to: 'comments#create'
  
  put '/creating_challenges/:id/accepted', to: 'challenges#accepted', as: 'challenge_accepted'
  put '/creating_challenges/:id/rejected', to: 'challengess#rejected', as: 'challenge_rejected'
  put '/offers/:id/accept', to: 'offers#accept', as: 'accept_offer'
  put '/offers/:id/reject', to: 'offers#reject', as: 'reject_offer'

  
  mount ActionCable.server => '/cable'
 
 
 resources :fixtures do
    member do
      delete :delete_photo
      post :upload_photo
    end
    resources :challenges, only: [:create]
  end
   
   resources :requests
   
  devise_for :users, 
              path: '', 
              path_names: {sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
 
  
end
