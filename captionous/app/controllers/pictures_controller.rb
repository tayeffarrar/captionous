class PicturesController < ApplicationController

	def configure
		Instagram.configure do |config|
			config.client_id = Rails.application.secrets.instagram_client_id
			config.client_secret = Rails.application.secrets.instagram_client_secret
			@client = Instagram.client 
		end
	end

	def fetch_results
		@pictures_array = []
		@data_array = []
		@results.each do |result|
			@pictures_array << Picture.create!(
				:url => result.images.standard_resolution.url, 
				:contributor => result.user[:username]
			)
		end

		@pictures_array.map do |pic|
			@data_array << {url: pic.url}
		end
	end

	def create
		self.configure

		@results = @client.tag_recent_media(params[:keyword])
		self.fetch_results
		
		respond_to do |format|
			format.json {render json: @data_array}
		end
	end

	# def show
	# 	self.configure
		
	# 	@results = @client.media_popular
	# 	self.fetch_results

	# 	Pry.start(binding)
	# 	respond_to do |format|
	# 		format.json {render json: @data_array}
	# 	end
	# end

end
