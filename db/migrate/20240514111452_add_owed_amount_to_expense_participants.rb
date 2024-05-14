class AddOwedAmountToExpenseParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :expense_participants, :owed_amount, :decimal
  end
end
