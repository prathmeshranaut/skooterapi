class UserController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	def create_user
		user = User.find_or_create_by(user_params)
		if user.save
	        render json: {response: "Done", user: {id: user.to_hashed_id, access_token: user.access_token}}, status: :ok
		else
	        render json: {response: "Error"}, status: 501
		end
	end

	def add_registration_id
		user = current_user
		user.registration_id = params[:registration_id]
		if user.save
	        render json: {response: "Done"}, status: :ok
	    else
	        render json: {response: "Error"}, status: 501
	    end
	end

	def add_notify
		user = current_user
		user.notify = params[:notify]
		if user.save
	        render json: {response: "Done"}, status: :ok
	    else
	        render json: {response: "Error"}, status: 501
	    end
	end

	private

	def user_params
		params.permit(:device)
	end

end
