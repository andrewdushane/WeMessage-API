class Account < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { in: 6..20 }
  has_secure_password
  has_and_belongs_to_many :contacts,
    class_name: "Account",
    join_table: :contacts,
    foreign_key: :adder_id,
    association_foreign_key: :added_id
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_account'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_account'
  def self.find_by_credentials(email, password)
    account = Account.find_by(email: email)
    if account && account.authenticate(password)
      return account
    else
      return nil
    end
  end
end
