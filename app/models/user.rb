class User < ActiveRecord::Base
	has_secure_password

	has_many :products, through: :sales
	has_many :product_sales, through: :sales, :source => :products



	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name, :last_name, :presence => true

	validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }

	validates :password, :presence => true, allow_nil: true, confirmation: true
end
