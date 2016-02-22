class Product < ActiveRecord::Base
	has_one :sale
	belongs_to :user
end
