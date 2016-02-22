Rails.application.routes.draw do
  
	get '/sessions' => 'sessions#new' #<----- This is initial route when web page is loaded up

	get '/users/:id' => 'users#show' #<------ This comes from user controller 'login' method

	get '/users/:id/dashboard' => 'users#dashboard'

	get '/user/:id/buy' => 'users#buy' # this carries the product id

	post '/users' => 'users#login'  #<------- When existing user logs in from views > sessions > new.html.erb

	post '/users/:id/create' => 'users#create'

	post '/sessions' => 'sessions#create' #<---- When new user signs up from views > sessions > new.html.erb

	delete '/users/:id' => 'users#destroy'

	delete '/sessions' => 'sessions#destroy' #<---- When user logs out
end
