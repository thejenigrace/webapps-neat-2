class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :plan_id
      t.string :start_date
      t.string :end_date
      t.string :total_price

      t.timestamps null: false
    end
  end
end
