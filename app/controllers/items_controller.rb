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
    @item = @category.items.build
  end

  def create
    @item = @category.items.build(item_params)
    if @item.save
      if @item.category.name == 'Hops'
        redirect_to category_path(1), notice: 'Item was created.'
      elsif @category.name == 'Malts'
        redirect_to category_path(2), notice: 'Item was created.'
      elsif @item.category.name == 'Yeasts'
        redirect_to category_path(3), notice: 'Item was created.'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to edit_category_item_path(@category, @item), notice: "Item updated"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to category_path(@category), notice: "Item destroyed"
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :unit, :color, :price,
                                 :origin, :alpha, :item_type, :date, :notes,
                                 :supplier, :form, :attenuation, :potential,
                                 :yield, :item_category)

  end
end
