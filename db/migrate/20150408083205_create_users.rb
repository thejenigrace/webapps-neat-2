class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt
      t.boolean :email_confirmed
      t.string :confirm_token
      t.string :billing_address

      t.timestamps null: false
    end
  end
end
