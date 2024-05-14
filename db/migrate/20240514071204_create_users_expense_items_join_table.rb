class CreateUsersExpenseItemsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :users_expense_items, id: false do |t|
      t.references :user, foreign_key: true
      t.references :expense_item, foreign_key: true
    end

    # Add index to optimize queries involving the join table
    add_index :users_expense_items, [:user_id, :expense_item_id], unique: true
  end
end
  