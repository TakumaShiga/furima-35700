class PurchaseAddress 
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
   validates :user_id
   validates :item_id
   validates :postal_code, format: {with:  /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンを含む半角英数字で入力してください"}
   validates :city
   validates :house_number
   validates :phone_number 
   validates :token
  end
    validates :prefecture_id, numericality: {other_than: 1, message: "を選択してください"}
    validates :phone_number, numericality: {with: /\A\d{10,11}\z/, message: "は11桁以内の半角数字で入力してください"}
    validates :phone_number, length: { maximum: 11 }
  

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
   
end