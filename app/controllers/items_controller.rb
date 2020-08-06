class ItemsController < ApplicationController
  require 'payjp'
  before_action :creditcard
  def index
  end
  def new
    @item = Item.new
    # @item.item_images.new

    #カテゴリボックスの定義
    @category_parent_array = Category.where(ancestry: nil)
  end
  #カテゴリーの定義
  def get_category_children
 
    @category_children = Category.find(params[:parent_id]).children
  end

 
  def get_category_grandchildren
  
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  def buy
    @address = Address.where(user_id: current_user.id).first
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      #カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を引っ張ってくる
      :customer => @card.customer_id,  #顧客ID
      :currency => 'jpy',              #日本円
    )
    redirect_to done_item_buyers_path #完了画面に移動
  end

  private

  def set_creditcard
    @creditcard = Credit_card.where(user_id: current_user.id).first if Credi_tcard.where(user_id: current_user.id).present?
  en

  def set_item
    @item = Item.find(params[:item_id])
  end



end
