class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'Account', :foreign_key => 'sender_account'
  belongs_to :recipient, :class_name => 'Account', :foreign_key => 'recipient_account'
end
