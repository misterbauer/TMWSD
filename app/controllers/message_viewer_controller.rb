class MessageViewerController < ApplicationController

  def new
  	message = Message.find_by(token: params[:token])
  	debugger
  	if (!message)
  		redirect_to 'message/deleted'
  	elseif message.password == ""
  		render 'message/show'
  	else
  		render 'password'
  	end
  end

	def create
    message = Message.find_by(token: params[:token])
    debugger
    if message.password == params[:password]
      redirect_to controller: 'message', action: 'show', :token => params[:token]
    else
      flash.now[:danger] = 'Invalid password'
      render 'password'
    end
  end


end
