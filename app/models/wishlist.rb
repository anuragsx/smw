class Wishlist < ActiveRecord::Base
	belongs_to :users
	validates_presence_of :listingtype
end
