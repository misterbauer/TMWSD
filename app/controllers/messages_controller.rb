class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    if logged_in?
      @message = current_user.messages.new(message_params)
    else
      @message = Message.new(message_params)
    end

    @message.key = get_unique_key
    if (@message.save)
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
