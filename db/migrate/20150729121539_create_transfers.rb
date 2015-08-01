class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.references :sender
      t.references :recipient
      t.integer :transfer_amount
      t.timestamps null: false
    end
  end
end
