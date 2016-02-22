class SessionsController < ApplicationController

	def new
	end

	def create
		User.create(first_name:params[:first_name],last_name:params[:last_name],email:params[:email],password:params[:password])

		user = User.find_by_email(params[:email])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/users/%d' % session[:user_id]
		else
			flash[:errors] = ["Invalid combination"]
			redirect_to :back
		end
	end
	
	def dashboard	
	end


	def destroy
		session[:user_id] = nil # this turns current session to inactive
		redirect_to '/sessions'
	end

end
