class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :description
  end
  
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { 
    only_integer: true, greater_than_equal_to: 300,
    less_than_equal_to: 9_999_999 
    }
  end

  with_options numericality: { other_than: 1} do
    validates :category_id        
    validates :condition_id      
    validates :prefecture_id    
    validates :shipping_burden_id 
    validates :shipping_date_id 
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :condition
    belongs_to :prefecture 
    belongs_to :shipping_burden 
    belongs_to :shipping_date 
    
end
