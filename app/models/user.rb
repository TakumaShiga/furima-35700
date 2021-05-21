class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

  with_options format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'には全角（ひらがな、カタカナ、漢字）で入力してください' } do
    validates :family_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力して下さい。'} do
    validates :family_name_k
    validates :first_name_k
  end

  with_options presence: true  do 
    validates :nickname
    validates :birth_day
  end  

  validates :email, uniqueness: true
end
