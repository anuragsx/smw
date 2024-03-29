class Listing < ActiveRecord::Base
	validates_presence_of :listingtype
	validates_numericality_of :price, :mileage, :allow_nil => true, :message => "is not a number or contains extra characters.  Please use only numbers."
	belongs_to :users
	belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
	has_many :messages
	has_many :photos, :dependent => :destroy
	has_many :wishlists, :foreign_key => "user_id", :primary_key => "user_id"
#will_paginate stuff
	cattr_reader :per_page
  @@per_page = 50

	#default_scope :conditions => ["expired_at >= ?", Date.today]
end
