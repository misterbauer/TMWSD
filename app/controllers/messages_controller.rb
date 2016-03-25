class MessagesController < ApplicationController
  
  def show
  	#@user = User.find(params[:id])
  	message_from_db = Message.find_by_token(params[:token])
  	message_exists = !!message_from_db
  	#debugger
  	if !message_exists
  		render 'deleted'
  	else
  		@message = message_from_db.destroy
  	end
  end

  def new
  end

  def deleted
  end
end
