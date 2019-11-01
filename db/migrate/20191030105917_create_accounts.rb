class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :acount_id
      t.integer :cash
      t.string :title
      t.string :type

      t.timestamps
    end
  end
end
