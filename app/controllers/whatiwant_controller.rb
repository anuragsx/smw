class WhatiwantController < ApplicationController

	def whatiwant
		@user = current_user
		@automakes = Automodels.find(:all, :order => 'make ASC', :select => 'distinct make')
		@automodels = "" #send a blank list when the page is first loaded so it can be replaced by the partial when a Make is selected
		@autocategories = Autocategories.find(:all, :order => 'category ASC')
		@motocategories = Motocategories.find(:all, :order => 'category ASC')
		@motomakes = Motomakes.find(:all, :order => 'sort_order ASC')
		@marinecategories = Marinecategories.find(:all, :order => 'category ASC', :select => 'distinct category')
		@marinesubcategories = "" #Marinecategories.find(:all, :order => 'subcategory ASC')
		@marinemakes = Marinemakes.find(:all, :order => 'make ASC')
		@powercategories = Powercategories.find(:all, :order => 'category ASC', :select => 'distinct category')
		@powersubcategories = "" #Powercategories.find(:all, :order => 'subcategory ASC')
		@powermakes = Powermakes.find(:all, :order => 'sort_order ASC')
		@search = Listing.new_search(params[:search])
	#	@listings = @search.all
  #	@listings_count = @search.count
	end
	
	def get_automodels
		@automodels = Automodels.find_all_by_make(params[:make], :order => "model ASC").map{|m| [m.model, m.model]}
		
		render :update do |page|
			page.replace_html('automodelsdiv', :partial => 'automodels_select', :object => @automodels)
		end
	end

	def get_marinesubcategories
		@marinesubcategories = Marinecategories.find_all_by_category(params[:category], :order => "subcategory ASC").map{|m| [m.subcategory, m.subcategory]}
		
		render :update do |page|
			page.replace_html('marinesubcategoriesdiv', :partial => 'marinesubcategories_select', :object => @marinesubcategories)
		end
	end

	def get_powersubcategories
		@powersubcategories = Powercategories.find_all_by_category(params[:category], :order => "subcategory ASC").map{|m| [m.subcategory, m.subcategory]}
		
		render :update do |page|
			page.replace_html('powersubcategoriesdiv', :partial => 'powersubcategories_select', :object => @powersubcategories)
		end
	end

end
