class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :condition
    belongs_to :prefecture 
    belongs_to :shipping_burden 
    belongs_to :shipping_date 
  
  belongs_to :user
  has_one_attached :image

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' } 
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300円以上9,999,999円以下を入力してください'}

  with_options presence: true do
    validates :name
    validates :image
    validates :description
  
    with_options numericality: { other_than: 1, message: 'を選択してください'} do
      validates :category_id        
      validates :condition_id      
      validates :prefecture_id    
      validates :shipping_burden_id 
      validates :shipping_date_id 
    end
  end
end
