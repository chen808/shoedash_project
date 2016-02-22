class UsersController < ApplicationController

	def show
		@user = User.find(params[:id]) # Find the current user info by id and store info @user, send to views > users > show.html.erb
		# @all_products = Product.all
		@all_products = Product.where(sold: false) # return updated product list excluding 'sold (true)' items
	end


	def login
		@user = User.find_by_email(params[:email]) # find user by email, if any, store into @user

		if @user && @user.authenticate(params[:password]) # does user password match up?
			session[:user_id] = @user.id # store user id to session (so that it can be used later on)
			redirect_to '/users/%d' % session[:user_id] 
		else
			flash[:errors] = ["Invalid combination"] # if validation fails, send error warning
			redirect_to :back
		end
	end


	def dashboard
		@user = User.find(params[:id])
		session[:first_name] = @user.first_name # get the current user first name

		# find only the products from current user that are not sold yet (finding by first_name)
		# @user_products = Product.where(seller:@user.first_name)
		@user_products = Product.where('seller = ? AND sold = ?', session[:first_name], false) # only return not sold items

		# find the total amount of sales for current user
		# goes into 'Products' model, finds the current user, which item was marked 'true' and sums up that amount
		@user_sales_total = Product.where("seller = ? AND sold = ?", session[:first_name], true).sum(:amount)

		# grab all the products that were sold (marked 'true')
		@all_products = Product.where("sold = ?", true)

		# grab all the products that user had sold and display, also displays the buyer's name
		@user_product_sold = Product.where("seller = ? AND sold = ?", session[:first_name], true)

		@purchases_total = Product.where(sold: true).sum(:amount) # return the sum amount of product list where items sold
	end


	def create
		# find the user name
		@current_user = User.find(params[:id])

		# create the new product with current user's name, product name and amount from 'dashboard.html.erb'
		@new_product = Product.create(product:params[:product], seller:@current_user.first_name, amount:params[:amount])

		# create a link in 'Sale' table. Using incoming id (from views > users > dashboard.html.erb
		# and instance variable (created above) for product
		Sale.create(user_id:params[:id], product_id:@new_product.id)

		redirect_to '/users/%d/dashboard' % session[:user_id]
	end


	def buy
		# when current user buys item, update the product id, change the 'sold' column from
		# false to true and add the current user's name to 'buyer' column
		Product.update(params[:id], sold:"true", buyer:session[:first_name])
		redirect_to :back
	end


	def destroy
		@product_to_destroy = Product.find(params[:id]) # find the product by incoming product id (from dashboard.html.erb)
		@product_to_destroy.destroy
		redirect_to :back
	end

end
