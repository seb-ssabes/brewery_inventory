class ItemsController < ApplicationController
  before_action :set_category, except: [:toggle_sort]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @category = Category.find(params[:category_id])
    @sort_by = params[:sort_by] || 'quantity'
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
      Rails.logger.debug "Validation errors: #{@item.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      Rails.logger.debug("Flash Notice: #{flash[:notice]}")
      flash[:notice] = "Item updated"

      redirect_to case @item.category.name
                  when 'Hops'
                    category_path(1)
                  when 'Malts'
                    category_path(2)
                  when 'Yeasts'
                    category_path(3)
                  else
                    category_path(1)
                  end
    else
      Rails.logger.error("Failed to update item: #{@item.errors.full_messages}")
      flash.now[:alert] = @item.errors.full_messages.to_sentence
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "item_flash") }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy
    redirect_to category_path(@category)
    flash[:notice] = "Item was successfully deleted"
  end

  def toggle_sort
    @category = Category.find(params[:category_id])
    @items = @category.items
    @sort_by = params[:sort_by] || "quantity"

    render partial: "items/item_list", locals: { items: @items, category: @category, sort_by: @sort_by }
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
