Kids360::Application.routes.draw do
  resources :organizations

  resources :authorizations

  resources :children

  resources :parents

  root 'parents#splash'

  get 'children/:id/modal/' => 'children#modal', as: 'children_modal'

  post 'organizations/add' => 'organizations#create_add', as: 'organization_create_add'

  get 'sessions/new' => 'sessions#new', as: 'new_session'
  post 'sessions/' => 'sessions#create', as: 'sessions'
  delete 'sessions/' => 'sessions#destroy'

  get 'token/confirmation_request' => "sessions#confirm", as: 'confirm'
  get 'token/:value' => "sessions#token", as: 'token'

  get 'sessions/reset' => 'sessions#reset', as: 'reset'
  post 'sessions/reset' => 'sessions#submit_reset'
  delete 'sessions/reset' => 'sessions#new_password'

  post 'sessions/contact' => 'sessions#contact', as: 'contact_form'
  get 'sessions/thankyou' => 'sessions#thankyou'
  get 'sessions/confirmed' => 'sessions#confirmed'

end
