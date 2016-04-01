class MessageViewerController < ApplicationController
  before_action :correct_user_logged_in, only: [:details]

		def details
			message = return_message(params[:key])
			if !message || message.is_deleted?
			  go_to_missing
				return
			else
				@message = message
			end
	  end

	def addtoken
		@message = return_message(params[:key])
		if (!@message)
			go_to_missing
		else
			@message.tokens.create(key: get_unique_token_key)
			render 'details'
	  end
	end

  def view
  	token = return_token(params[:key])
    if !token
      go_to_missing
      return
    end
    message = token.message
    if message.password_digest.nil?
      show_and_destroy_message(token)
    else
      render 'password'
    end
  end

  def validate
  	token = return_token(params[:key])
    if !token || !message = token.message
      go_to_missing
    elsif message.authenticate(params[:password])
      show_and_destroy_message(token)
    else
      flash.now[:danger] = 'Invalid password'
      render 'password'
    end
  end

  private

  	def message_params
  		params.require(:message).permit(:message, :password)
  	end

    def token_exists?(key)
      !!Token.find_by(key: key)
    end

    def show_and_destroy_message(token)
      @message = token.destroy.message
      flash.now[:danger] = "This message has been deleted."
      render 'show'
    end

    def get_unique_token_key
      loop do
        key = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        return key if !Token.find_by(key: key)
      end
  	end

    def return_token(key)
    	Token.find_by(key: key)
    end

    def return_message(key)
      Message.find_by(key: key)
    end

    def go_to_missing
  		redirect_to '/missing'
  	end

    def go_to_login
      flash[:danger] = "Please log in."
      redirect_to login_url
    end

    def correct_user_logged_in()
      message = return_message(params[:key])
      if !!message && !!message.user_id
        unless logged_in? && message.user_id == current_user.id
          go_to_login
        end
      end 
    end

end
