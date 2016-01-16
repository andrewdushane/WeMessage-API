class Account < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { in: 6..20 }
  has_secure_password
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_account'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_account'
end
