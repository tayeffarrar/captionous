class Search < ActiveRecord::Base
	has_many :pictures
	has_many :captions

	before_create: fetch_results

	# def fetch_results
	# 	results = instagram.tag_recent_media(keyword)
	# 	# binding.pry
	# 	results.each do |result|
	# 		self.pictures << Picture.new {
	# 			url: result.images.standard_resolution
	# 		}
	# 	end
	# end

end
