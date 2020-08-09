class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @item_3 = @items.order('updated_at DESC').first(3)
    # @to_comments = Comment.where(user_id: current_user.id)
    # @be_commented = Comment.where.not(user_id: current_user.id).where(item_id: @items.ids)
  end
end
