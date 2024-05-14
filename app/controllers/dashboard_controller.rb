class DashboardController < ApplicationController
  def index
    @users = User.all
    @total_balance = calculate_total_balance(current_user)
    @total_you_owe = calculate_total_you_owe(current_user)
    @total_you_are_owed = calculate_total_you_are_owed(current_user)
    @friends_you_owe = find_friends_you_owe(current_user)
    @friends_who_owe_you = find_friends_who_owe_you(current_user)
  end

  private

  def calculate_total_balance(user)
    total_owed_to_you = ExpenseParticipant.where(user_id: user.id).sum(:owed_amount)
    total_you_owe = ExpenseParticipant.where(expense_id: user.expenses.pluck(:id)).sum(:owed_amount)
    total_balance = total_owed_to_you - total_you_owe
    total_balance
  end

  def calculate_total_you_owe(user)
    total_you_owe = ExpenseParticipant.where(expense_id: user.expenses.pluck(:id)).sum(:owed_amount)
    total_you_owe
  end

  def calculate_total_you_are_owed(user)
    total_you_are_owed = ExpenseParticipant.where(user_id: user.id).sum(:owed_amount)
    total_you_are_owed
  end

  def find_friends_you_owe(user)
    friends_you_owe = User.joins(:expense_participants)
    .where("expense_participants.user_id != ? AND expense_participants.owed_amount > 0", user.id)
    .group("users.id")
    .sum("expense_participants.owed_amount")
    friends_you_owe.empty? ? "You don't owe anyone." : friends_you_owe
  end

  def find_friends_who_owe_you(user)
    friends_who_owe_you = User.joins(:expense_participants)
    .where("users.id != ? AND expense_participants.user_id = ? AND expense_participants.owed_amount > 0", user.id, user.id)
    .group("users.id")
    .sum("expense_participants.owed_amount")
    friends_who_owe_you.empty? ? "No one owes you." : friends_who_owe_you
  end
end
