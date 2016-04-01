class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if (@user.save)      
      log_in @user
      first_name = @user.name.split(" ")[0]
  		flash[:success] = "Welcome to the site, #{first_name}!"
      redirect_to(@user)
  	else
  		render 'new'
  	end
  end

  private
  	def user_params
  		params.require(:user).permit(:name,:email,:password,:password_confirmation)
  	end

    # Before filters
    def logged_in_user
      unless logged_in? && current_user.id.to_s == params[:id]
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
