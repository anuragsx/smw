class HomeController < ApplicationController
	layout "application", :except => :index
  def index
  	@featuredauto = Listing.first(:conditions => {:featured => true, :listingtype => 'auto'})
  	@featuredmoto = Listing.first(:conditions => {:featured => true, :listingtype => 'moto'})
  	@featuredmarine = Listing.first(:conditions => {:featured => true, :listingtype => 'marine'})
  	@featuredpower = Listing.first(:conditions => {:featured => true, :listingtype => 'power'})
  	
  	#@automakes = Automodels.find(:all, :order => 'make ASC', :select => 'distinct make')
  	#@automodels = ""
  	#@autocategories = Autocategories.all
  	#@search = Listing.new_search(params[:search]) TODO
    @search = Listing.all
    unless @search.blank?
      @listings = @search.all
      @listings_count = @search.count
    end

  	
  	render :action => "index", :layout => "home"
  end

  def faq
  end

  def about
  end

  def contact
  	@message = Message.new
  end
  
  def admin
  	@user = current_user
  	if @user
  		if @user.admin
  			render
  		else
  			flash[:notice] = 'Restricted Page'
  			redirect_to(root_url)
  		end
  	else
  		flash[:notice] = 'Restricted Page'
 			redirect_to(root_url)
 		end
  end
  
end
