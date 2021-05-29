class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params_id
  before_action :move_to_index 
  before_action :prohibit_purchase

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
    @purchase_address.save
    redirect_to root_path
    else  
      render :index
    end
  end   

  private

    def item_params_id
      @item = Item.find(params[:item_id])
    end

    def move_to_index
      if current_user.id == @item.user_id
        redirect_to root_path
      end
    end

    def prohibit_purchase
      if @item.purchase.present?
        redirect_to root_path
      end
    end

    def purchase_params
      params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token] )
    end

    def pay_item
      Payjp::api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount:    @item.price,
        card:      purchase_params[:token],
        currency: 'jpy'
      )
    end
  end
