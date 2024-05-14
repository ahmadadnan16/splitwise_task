class UsersController < ApplicationController
  def show
    @friend = User.find(params[:id])
    @expenses = @friend.expenses.includes(:user)
  end
end
