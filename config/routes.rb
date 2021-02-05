Rails.application.routes.draw do
  resources :postcode_checker, only: %i[create index], path: '/'
end
