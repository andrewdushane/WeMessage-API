class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.boolean :delivered
      t.integer :sender_account, index: true, foreign_key: :accounts
      t.integer :recipient_account, index: true, foreign_key: :accounts

      t.timestamps null: false
    end
  end
end
