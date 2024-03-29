class MessagesController < ApplicationController

  def inbox
    @messages = current_user.received_messages.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  def sent
    @messages = current_user.sent_messages.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
  	if current_user
  		@message = Message.find(params[:id])
		  if current_user.id == @message.sender_id or current_user.id == @message.recipient_id
			  @message.read_at = Time.now
			  @message.save
			else
				not_authorized = true
		  end
		else
			not_authorized = true
		end

    respond_to do |format|
    	if not_authorized == true
    		flash[:notice] = 'You are not authorized to view that message.'
    		format.html {redirect_to root_url}
    	else
	      format.html # show.html.erb
  	    format.xml  { render :xml => @message }
  	  end
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    @sender = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
	def reply
    @original_message = Message.find(params[:message][:id])
    @message = Message.new
		@sender = current_user
		
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @message }
    end
  end
  
  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully sent.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
      	flash[:notice] = 'Message was not sent.  Please check required fields.'
      	format.html { redirect_to :back }
        #format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

	def create_reply
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Reply Message was successfully sent.'
        format.html { redirect_to sent_url }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
      	flash[:notice] = 'Reply Message was not sent.  Please check required fields.'
      	format.html { redirect_to :back }
				format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    if params[:inbox] == "1"
    	@message = current_user.received_messages.find(params[:id])
    	@message.update_attribute("recipient_deleted_at", Time.now)
    	flash[:notice] = 'Message was successfully deleted.'
    	redirect_to inbox_url
    elsif params[:sent] == "1"
	    @message = current_user.sent_messages.find(params[:id])
    	@message.update_attribute("sender_deleted_at", Time.now)
    	flash[:notice] = 'Message was successfully deleted.'
    	redirect_to sent_url
    end
  end
end
