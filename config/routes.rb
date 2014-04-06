ToTheMarket::Application.routes.draw do
  namespace :api do
    namespace :v1, :defaults => {:format => 'json'} do
      resources :markets, :only => [:index, :show] do
        resources :products, :only => [:index]
        resources :payment_types, :only => [:index]
        resources :schedules, :only => [:index]
      end
      get '/search/markets', to: 'searches#markets'
    end
  end
end
