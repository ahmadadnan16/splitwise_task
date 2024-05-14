class Expense < ApplicationRecord
  belongs_to :user
  has_many :expense_items, dependent: :destroy
  has_many :expense_participants, dependent: :destroy
  accepts_nested_attributes_for :expense_items, :expense_participants
end
