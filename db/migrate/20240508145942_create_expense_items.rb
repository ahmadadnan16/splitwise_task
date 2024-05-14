class CreateExpenseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_items do |t|
      t.text :description
      t.decimal :amount
      t.boolean :is_shareable
      t.references :expense, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
