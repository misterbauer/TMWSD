class Message < ActiveRecord::Base
	validates(:message, presence: true)
	has_many :tokens
	has_secure_password :validations => false

	def is_deleted?
		return self.tokens.count == 0
	end
end
