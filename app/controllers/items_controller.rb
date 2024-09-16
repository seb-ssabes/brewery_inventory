class ItemsController < ApplicationController
  before_action :set_category
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items
  end

  def show

  end

  def new
    @item = Category.items.build
  end

  def create
    @item = @category.item.build(item_params)
    if @item.save
      redirect_to category_items_path(@category), notice: "Item created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Item updated"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to category_items_path(@item.category), notice: "Item destroyed"
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :unit, :color)
  end
end
