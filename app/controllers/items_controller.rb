class ItemsController < ApplicationController
before_action :move_to_login, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
  end

  def create
  end


  def move_to_login
    unless user_signed_in?
     redirect_to new_user_session_path
    end
  end

end
