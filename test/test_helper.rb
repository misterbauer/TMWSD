ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
  	!session[:user_id].nil?
  end

  def log_in_user(id)
  	session[:user_id] = id
  end

  def log_out_user 
  	session.delete(:user_id)
    @current_user = nil
  end
end
