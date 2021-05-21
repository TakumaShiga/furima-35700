class ItemsController < ApplicationController
before_action :move_to_login, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  end


  def move_to_login
    unless user_signed_in?
     redirect_to new_user_session_path
    end
  end
  
  private
  def item_params
    params.require(:item).permit(
      :name, :description,:price, :category_id, 
      :condition_id, :shipping_burden_id, :prefecture_id,
      :shipping_date_id).merge(user_id: current_user.id)
    end
end
