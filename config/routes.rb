Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { confirmations: 'confirmations',
                                    omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    post 'confirm_email', to: 'omniauth_callbacks#confirm_email'
    authenticate :user do
      get 'profile', to: 'omniauth_callbacks#profile' # , as: :authenticated_root
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'questions#index'

  get '/search', to: 'search#show'

  # Example of regular route:
  get 'users/:id' => 'users#show', as: :user

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  concern :voting do
    post :good, :shit, :revoke, on: :member
  end

  resources :questions, concerns: [:voting] do
    post :subscribe, :unsubscribe, on: :member
    resources :comments, only: [:new, :create], defaults: { commentable: 'questions' }
    resources :answers, concerns: [:voting], shallow: true, except: :show do
      resources :comments, only: [:new, :create], defaults: { commentable: 'answers' }
      post :solution, on: :member
    end
  end

  namespace :api do
    namespace :v1 do
      resources :questions do
        resources :answers, shallow: true
      end
      resources :profiles do
        get :me, on: :collection
      end
    end
  end
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
