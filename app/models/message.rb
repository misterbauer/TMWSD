class Message < ActiveRecord::Base
	validates(:message, presence: true)
	has_many :tokens
	has_secure_password 
end
