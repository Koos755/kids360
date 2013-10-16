Kids360::Application.routes.draw do
  resources :organizations

  resources :authorizations

  resources :children

  resources :parents

  root 'parents#index'

  get 'children/:id/modal/' => 'children#modal', as: 'children_modal'

  post 'organizations/add' => 'organizations#create_add', as: 'organization_create_add'

end
