class PicturesController < ApplicationController

	def create
		Instagram.configure do |config|
			config.client_id = Rails.application.secrets.instagram_client_id
			config.client_secret = Rails.application.secrets.instagram_client_secret
		end

		# Pry.start(binding)
		client = Instagram.client 
		# client.media_popular
		# client.tag_search('')

		@results = client.tag_recent_media(params[:keyword])
		@pictures_array = []

		@results.each do |result|
			@pictures_array << Picture.create!(
				:url => result.images.standard_resolution.url, 
				:contributor => result.user[:username]
			)
		end

		respond_to do |format|
			format.json {render json: @pictures_array }
		end

	end	

	# def instagram
	# 	Instagram.configure do |config|
	# 		config.client_id = Rails.application.secrets.instagram_client_id
	# 		config.client_secret = Rails.application.secrets.instagram_client_secret
	# 	end
	# end

end
