class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	private
	# ensuring that there are no items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.emty?
			return true
		esle
			errors.add(:base, 'Line Items present')
			return false
		end
	end
	
	
	validates :title, :description, :image_url, presence:true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true #length: { minimum: 10 }
	validates :image_url, allow_blank:true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'Must be a URL for GIF, JPG or PNG image.'
	}
end
