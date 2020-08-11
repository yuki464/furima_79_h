class UsersController < ApplicationController
  require "payjp"
  before_action :set_card
  def show
    @user = User.find(params[:id])
    @user = current_user
    @items = current_user.items
    @parents = Category.where(ancestry: nil)
    # @item_3 = @items.order('updated_at DESC').first(3)
    # @to_comments = Comment.where(user_id: current_user.id)
    # @be_commented = Comment.where.not(user_id: current_user.id).where(item_id: @items.ids)
  end
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
