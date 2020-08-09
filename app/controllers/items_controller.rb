class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
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
    params.require(:item).permit(:name, :introduction, :price, :brand, :condition_id, :postage_payer, :prefecture_id, :preparationday_id, :category_id, item_images_attributes: [:url, :id]).merge(user_id: current_user.id)
  end
end
