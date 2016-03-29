class MessagesController < ApplicationController

  def show    
    @message = Message.find_by(key: params[:key])
    if (!@message)
      redirect_to "/"
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = User.find(3).messages.new(message_params)
    @message.key = get_unique_key
    if (@message.valid?)
      @message.save
      @message.tokens.create(key: get_unique_token_key)
      redirect_to controller: 'message_viewer', action: 'details', key: @message.key
    else
      render 'new'
    end
  end

  private
  def get_unique_token_key
      loop do
        key = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        return key if !Token.find_by(key: key)
      end
  end

  def get_unique_key
      loop do
        key = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        return key if !get_message_from_key(key)
      end
  end

  def get_message_from_key(key)
    Message.find_by(key: key)
  end

  def message_params
      params.require(:message).permit(:message, :password)
    end
end
