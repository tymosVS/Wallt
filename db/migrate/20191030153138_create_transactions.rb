class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :account_source
      t.string :account_destination
      t.integer :cash

      t.timestamps
    end
  end
end
