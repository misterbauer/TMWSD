class MessagesController < ApplicationController
  
  def show
  	message_from_db = Message.find_by_token(params[:token])
    #debugger
    @message = message_from_db.destroy
  end

  def new
  	@message = Message.new
  end

  def create
  	@message = Message.new(message_params)
  	if (@message.valid?)
  		@message.token = get_token
  		@message.save
  		render 'confirm'
  	else
  		render 'new'
    end
  end

  def view
    message = Message.find_by(token: params[:token])
    #debugger
    if !message
      render 'deleted'
    elsif message.password == ""
      @message = message.destroy
      render 'show'
    else
      render 'password'
    end
  end

  def validate
    message = Message.find_by(token: params[:token])
    if message.password == params[:password]
      @message = message.destroy
      render 'show'
    else
      flash.now[:danger] = 'Invalid password'
      render 'password'
    end
  end

  def confirm
  end

  def deleted
  end

  private
  	def message_params
  		params.require(:message).permit(:message, :password)
  	end

  	def get_token
  		[*('a'..'z'),*('0'..'9')].shuffle[0,8].join
  	end
end
