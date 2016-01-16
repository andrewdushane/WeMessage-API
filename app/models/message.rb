class Message < ActiveRecord::Base
  validates :content, presence: true
  validates :sender_account, presence: true
  validates :recipient_account, presence: true
  belongs_to :sender, :class_name => 'Account', :foreign_key => 'sender_account'
  belongs_to :recipient, :class_name => 'Account', :foreign_key => 'recipient_account'
  after_initialize :init

  def init
    self.delivered = false if self.delivered.nil?
  end
end
