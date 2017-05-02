Rails.application.routes.draw do
	# root to: "sessions#new"
	root to: 'welcome#landing'

	get   '/login', :to => 'sessions#new', :as => :login
	match '/auth/:provider/callback', :to => 'sessions#create', :via => [:get]
	match '/auth/failure', :to => 'sessions#failure', :via => [:get]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
