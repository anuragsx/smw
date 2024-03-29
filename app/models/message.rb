class Message < ActiveRecord::Base
	validates_presence_of :recipient_id, :subject, :body
	belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
	belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
	belongs_to :listing
end
