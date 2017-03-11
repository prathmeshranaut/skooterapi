class User < ActiveRecord::Base
	before_create :generate_access_token

	has_many :locations
	has_many :skoots
	has_many :replies
	has_many :like_skoots
	has_many :like_replies
	has_many :user_following_categories
	has_many :notifications
	has_many :flag_skoots
	has_many :flag_replies

	validates_presence_of :device


	def to_hashed_id
	    Hashids.new("3587e646ee5bc48e60fb7b29c7a43650961f33893846d8e06f83b528554518b352f563669db91e790ae781d2e9785baf2a2093acf2f6b7df434eebb72af6ce2f", 10).encode(id)
	end

	private

	def generate_access_token
		begin
			self.access_token = SecureRandom.hex
		end while self.class.exists?(access_token: access_token)
	end

end
