class PicturesController < ApplicationController

	def configure_instagram
		Instagram.configure do |config|
			config.client_id = Rails.application.secrets.instagram_client_id
			config.client_secret = Rails.application.secrets.instagram_client_secret
			@instagram_client = Instagram.client 
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

	def generate_default
		@defaults = ["sunset", "nyc", "la", "london", "paris", "tokyo", "caribbean", "worldnews", "sunrise", "mountain", "landscape", "newyork", "sky", "clouds", "music", "forest", "river", "ocean", "carniva", "politics", "bbq", "food", "parade", "holiday", "technology", "tech", "dog", "dogs", "nature", "happy", "cinema", "movies", "redcarpet", "blue", "red", "yellow", "sun", "museum", "football", "art"]
		@default = @defaults.sample
	end

	def create
		self.configure_instagram

		@results = @instagram_client.tag_recent_media(params[:keyword])
		self.fetch_results
		
		respond_to do |format|
			format.json {render json: @data_array}
		end
	end

	def show
		self.generate_default
		self.configure_instagram

		Pry.start(binding)
		
		@results = @instagram_client.tag_recent_media(@default)
		self.fetch_results

		
		respond_to do |format|
			format.html
			format.json {render json: @data_array}
		end
	end

end
