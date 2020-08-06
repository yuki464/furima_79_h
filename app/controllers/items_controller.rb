class ItemsController < ApplicationController
  def index
  end
  def new
    @item = Item.new
    @item.item_images.build

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
     if @item.save
      redirect_to root_path
     else
      @item.item_images.build
      render :new
     end
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :price, :brand_id, :condition_id, :postage_payer, :prefecture_id, :size_id, :preparationday_id, :postagetype_id)
  end
end
