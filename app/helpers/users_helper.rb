module UsersHelper
	def gravatar_for(user)
	  user_email_hash = Digest::MD5::hexdigest(user.email.downcase)
	  gravatar_url = "https://secure.gravatar.com/avatar/#{user_email_hash}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
