class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :image

      t.timestamps null: false
    end
  end
end
