class ItemsController < ApplicationController
  require "payjp"
  before_action :set_card, only:[:show]
  before_action :set_item, only:[:destroy,:show,:edit,:update]
  def index
    @items = Item.all
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
    @item= ItemImage.find(params[:id])
    if @item.delete
      redirect_to root_path, notice: '削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      render :show
    end
  end

  def create
     @item = Item.new(item_params)
     if  @item.save
      redirect_to root_path
     else
      render :new
     end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand, :condition_id, :postagepayer_id, :prefecture_id, :preparationday_id, :category_id, item_images_attributes: [:url, :id]).merge(user_id: current_user.id)
  end
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
  def set_item
    @item = Item.find(params[:id])
  end

end
