class Contact < ActiveRecord::Base
  validates :adder_id, presence: true
  validates :added_id, presence: true
  belongs_to :adder, :class_name => 'Account', :foreign_key => 'adder_id'
  belongs_to :added, :class_name => 'Account', :foreign_key => 'added_id'
end
