class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :cents
      t.references :user
      
      t.timestamps null: false
    end
  end
end
