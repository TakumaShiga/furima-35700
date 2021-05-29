class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  before_action :item_params_id, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :prohibit_access_purchase, only:[:edit, :update]
  

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  
  private

  def item_params_id
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

 def prohibit_access_purchase
    if @item.purchase.present?
      redirect_to action: :index
    end 
 end

  def item_params
    params.require(:item).permit(:image,:name,:description,:price,:category_id,:condition_id,:shipping_burden_id,:prefecture_id,:shipping_date_id).merge(user_id: current_user.id)
  end

end
