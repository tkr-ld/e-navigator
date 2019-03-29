Rails.application.routes.draw do

  root to: 'users#index'

  resources :users, only: [:index, :edit, :update] do
    resources :interviews do
      patch :approve
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
