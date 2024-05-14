class ExpensesController < ApplicationController
  include Current
	before_action :authenticate_user!
  after_action :distribute_expense, only: [:create]

  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
    @expense_items = @expense.expense_items.build
    @expense.expense_participants_ids = []
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      if params[:expense_items].present?
        @expense.expense_items.create(description: params[:expense_items][:description],
                                       amount: params[:expense_items][:amount], 
                                       is_shareable: params[:expense_items][:is_shareable], 
                                       user_id: params[:expense_items][:user_id])
      end

      if params[:expense_participants_ids].present?
        params[:expense_participants_ids].each do |user_id|
          @expense.expense_participants.create(user_id: user_id)
        end
      end
      redirect_to @expense, notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.permit(
      :description, :amount, :tax_amount, :date, :user_id,
      expense_items_attributes: [:id, :description, :amount, :is_shareable, user_ids: []], 
      expense_participants_attributes: [{ user_ids: [] }]
    )
  end

  def distribute_expense
    @total_amount = @expense.amount
    @total_amount += @expense.expense_items.pluck(:amount).sum
    @total_amount += @expense.tax_amount if @expense.tax_amount.present?

    shared_expense = @total_amount
    individual_expense = 0

    @expense.expense_items.each do |item|
      if item.is_shareable && item.expense.expense_participants.count > 1
        shared_expense -= item.amount
      else
        individual_expense += item.amount
      end
    end

    @expense.expense_participants.each do |participant|
      if participant.user_id == @expense.user_id
        participant.update(owed_amount: individual_expense)
      else
        participant.update(owed_amount: shared_expense / @expense.expense_participants.count)
      end
    end
  end
end
