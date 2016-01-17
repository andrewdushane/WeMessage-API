class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :adder_id, index: true, foreign_key: :accounts
      t.integer :added_id, index: true, foreign_key: :accounts

      t.timestamps null: false
    end
  end
end
