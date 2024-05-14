module ApplicationHelper
  def expense_participant_status(expense)
    participant = expense.expense_participants.find_by(user_id: current_user.id)
    if participant&.owed_amount.to_f > 0
      "Borrowed"
    elsif participant&.owed_amount.to_f < 0
      "Lent"
    else
      "Settled"
    end
  end
end
