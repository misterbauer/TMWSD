class Token < ActiveRecord::Base
  belongs_to :message
  validates :message_id, presence: 'true'
end
