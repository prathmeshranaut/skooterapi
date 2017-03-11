class CategoryController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def list
		category_ids = ZoneCategory.where(:zone_id => current_zone(current_location)[:id]).pluck(:category_id)
		categories = Category.where(:id => category_ids)
		@json = {}
		@json[:categories] = {}
		categories.each_with_index do |category, index|
			@json[:categories][index] = {}
			@json[:categories][index][:name] = category.name
			@json[:categories][index][:image_url] = category.image.url
			@json[:categories][index][:id] = category.id
		end
		render json: @json, status: :ok 
	end

end
