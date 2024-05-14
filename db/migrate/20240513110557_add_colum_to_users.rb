class AddColumToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_amount, :decimal
  end
end
