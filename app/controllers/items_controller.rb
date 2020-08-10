class ItemsController < ApplicationController
  require "payjp"
  before_action :set_card, only:[:buy,:pay]
  before_action :set_item, only:[:destroy,:show,:edit,:update,:buy,:pay]
  def index
    @items = Item.all
    @images = ItemImage.all
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.item_images.new
    else
      redirect_to root_path
    end
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
  def show
    @user = User.find(@item.user_id)
    @images = ItemImage.where(item_id: params[:id])
    @images_first = ItemImage.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def destroy
    if @item.user_id==current_user.id && @item.destroy
      redirect_to root_path, notice: '削除しました'
    else
      flash[:alert] = '削除できませんでした'
      render :show
    end
  end

  def buy
    if current_user.id == @item.user_id
      flash[:notice] = 'あなたが出品したのでしょう！！購入できません！'
      redirect_to root_path
    end
    @card = Card.where(user_id: current_user.id).first
    # #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_access_key]
      #保管した顧客IDでpayjpから情報取得
      @customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = @customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    if current_user.id == @item.user_id
      flash[:notice] = 'あなたが出品したのでしょう！！購入できません！'
      redirect_to root_path
    end
    @card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials[:payjp][:payjp_access_key]
    Payjp::Charge.create(
    amount: @item.price,
    customer: @card.customer_id, #顧客ID
    currency: 'jpy', #日本円
  )

  @item_buyer= Item.find(params[:id])
      if @item_buyer.update( buyer_id: current_user.id)
      redirect_to action:"done"
       else
      flash.now[:alert] = '正しく商品を購入できませんでした。'
      render :buy
      end
  end

  def done
    # @user = User.find(current_user.id)
  end

  def create
     @item = Item.new(item_params)
     if  @item.save
      redirect_to root_path
     else
      render :new
     end
  end

  def edit
  end

  def update
    if @item.update(update_params)
      redirect_to items_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand, :condition_id, :postagepayer_id, :prefecture_id, :preparationday_id, :category_id, item_images_attributes: [:url, :id]).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :introduction, :price, :brand, :condition_id, :postagepayer_id, :prefecture_id, :preparationday_id, :category_id, :user_id, item_images_attributes: [:url, :id])
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
  def set_item
    @item = Item.find(params[:id])
  end
end
