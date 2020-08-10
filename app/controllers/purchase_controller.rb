class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_card
  before_action :set_item
  # ばいはアイテムズにいこう
  # def buy
  #   @card = Card.where(user_id: current_user.id).first
  #   # #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
  #   if @card.blank?
  #     #登録された情報がない場合にカード登録画面に移動
  #     redirect_to controller: "card", action: "new"
  #   else
  #     Payjp.api_key = Rails.application.credentials[:payjp][:payjp_access_key]
  #     #保管した顧客IDでpayjpから情報取得
  #     @customer = Payjp::Customer.retrieve(@card.customer_id)
  #     #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
  #     @default_card_information = @customer.cards.retrieve(@card.card_id)
  #   end
  # end

  # def pay
  #   @card = Card.where(user_id: current_user.id).first
  #   Payjp.api_key = Rails.application.credentials[:payjp][:payjp_access_key]
  #   Payjp::Charge.create(
  #   amount: @item.price, 
  #   customer: @card.customer_id, #顧客ID
  #   currency: 'jpy', #日本円
  # )

  # @item_buyer= Item.find(params[:item_id])
  #     if @item_buyer.update( buyer_id: current_user.id)
  #     redirect_to action:  done
  #      else
  #     flash.now[:alert] = '正しく商品を購入できませんでした。'
  #     render :buy
  #     end
  # end 

  # def done
  #   # @user = User.find(current_user.id)
  # end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
  def set_item
    @item = Item.find(params[:item_id])
  end
end
