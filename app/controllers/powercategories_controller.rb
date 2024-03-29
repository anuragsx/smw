class PowercategoriesController < ApplicationController

	def index
  	
    respond_to do |format|
    	@user = current_user
    	if @user
    		if @user.admin
	    		@powercategories = Powercategories.find(:all, :order => 'category ASC, subcategory ASC')
		      format.html # index.html.erb
		    else
		    	flash[:notice] = 'Restricted Page'
		    	format.html {redirect_to(root_url)}
		    end
	    else
	    	flash[:notice] = 'Restricted Page'
	    	format.html {redirect_to(root_url)}
	    end
    end
  end

  def new

    respond_to do |format|
    	@user = current_user
    	if @user
    		if @user.admin
	    		@powercategory = Powercategories.new
		      format.html # new.html.erb
		    else
		    	flash[:notice] = 'Restricted Page'
		    	format.html {redirect_to(root_url)}
		    end
	    else
	    	flash[:notice] = 'Restricted Page'
	    	format.html {redirect_to(root_url)}
	    end
    end
  end

  def create
    @powercategory = Powercategories.new(params[:powercategories])

    respond_to do |format|
      if @autocategory.save
        flash[:notice] = 'Power Category was successfully created.'
        format.html { redirect_to :back }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @powercategory = Powercategories.find(params[:id])
    @powercategory.destroy

    respond_to do |format|
    	flash[:notice] = 'Power Category was successfully removed.'
      format.html { redirect_to(powercategories_path) }
    end
  end
end
