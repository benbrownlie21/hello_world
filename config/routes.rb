Rails.application.routes.draw do
  # Add the "do" here to open the block
  resources :articles do
    member do
      patch :set_archived
      patch :set_unarchived
    end
  end # This end closes the resources :articles block

  # The rest of your routes stay exactly the same
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root 'pages#home'
  get 'about', to: 'pages#about'
end