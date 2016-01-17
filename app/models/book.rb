class Book < ActiveRecord::Base

	validates :isbn, :presence => true, :length => {:in => 10..13}

	belongs_to :user

	mount_uploader(:image, ImageUploader)

	def image_url= (i)
		if i
			self.remote_image_url = i
		end
	end
end
