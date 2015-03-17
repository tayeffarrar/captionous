class PicturesController < ApplicationController

	def configure_instagram
		Instagram.configure do |config|
			config.client_id = ENV["_FIGARO_instagram_client_id"]
			config.client_secret = ENV["_FIGARO_instagram_client_secret"]
			@instagram_client = Instagram.client
		end
	end

	def configure_twitter
		client = Twitter::REST::Client.new do |config|
			config.consumer_key = "pu4D6ohzf9yG8XlM9hpJFAGWr"
			config.consumer_secret = "LNIimgn64o4jWpCgW3yNMLDoctjq4P8JvGU6L0sc33UuiRh6eZ"
			config.access_token = "43109004-OW0dzDk1SyzW07VmLlUhyAcPfi9IhhdOfReerUA8s"
			config.access_token_secret = "B7fQOSnL5R765OxWlOmYAlGN4p3uZcNaOiWokHyey7YLX"
		end
		@twitter_client = client
	end

	def generate_default
		@defaults = ["sunset", "nyc", "la", "london", "paris", "tokyo", "caribbean", "worldnews", "sunrise", "mountain", "landscape", "newyork", "sky", "clouds", "music", "forest", "river", "ocean", "carniva", "politics", "bbq", "food", "parade", "holiday", "technology", "tech", "dog", "dogs", "nature", "happy", "cinema", "movies", "redcarpet", "blue", "red", "yellow", "sun", "museum", "football", "art"]
		@default = @defaults.sample
	end

	def fetch_instagram_results
		@pictures_array = []
		@data_array = []
		@instagram_results.each do |result|
			@pictures_array << Picture.create!(
				:url => result.images.standard_resolution.url,
				:contributor => result.user[:username]
			)
		end

		@pictures_array.map do |pic|
			@data_array << {url: pic.url}
		end
	end

	def create_instagram
		self.configure_instagram

		@instagram_results = @instagram_client.tag_recent_media(params[:keyword])
		self.fetch_instagram_results

		respond_to do |format|
			format.json {render json: @data_array}
		end
	end

	def show_instagram
		self.generate_default
		self.configure_instagram

		@instagram_results = @instagram_client.tag_recent_media(@default)
		self.fetch_instagram_results


		respond_to do |format|
			format.html
			format.json {render json: @data_array}
		end
	end

	def create
		self.create_instagram
		#self.create_twitter
	end

	def show
		self.show_instagram
		#self.show_twitter
	end

end
