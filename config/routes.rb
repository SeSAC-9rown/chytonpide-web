Rails.application.routes.draw do
	root "pages#home"
	get "/log", to: "pages#log", as: :log
	get "/mypage", to: "pages#mypage", as: :mypage
	
	# Health check
	get "/up", to: "rails/health#show", as: :rails_health_check
	
	# Sessions
	get "/login", to: "sessions#new", as: :login
	get "/auth/google_oauth2/callback", to: "sessions#create", as: :google_auth
	delete "/logout", to: "sessions#destroy", as: :logout
	
	# Endpoints
	resources :users, except: [:index, :show], as: :users do
		resource :device, except: :show, as: :device do
			resource :kit, except: :show, as: :kit
		end
		resources :logs, except: [:index, :show], as: :logs
	end

	# Sensor data
	post '/sensor_data', to: 'sensor_data#create'
end