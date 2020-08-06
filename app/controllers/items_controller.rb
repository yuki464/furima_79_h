class ItemsController < ApplicationController
  require 'payjp'
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

  private



end
