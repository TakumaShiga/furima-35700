class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, uniqueness: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 
  with_options presence: true do
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'には全角（ひらがな、カタカナ、漢字）で入力してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'には全角（ひらがな、カタカナ、漢字）で入力してください' }
    validates :family_name_k, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力して下さい。' }
    validates :first_name_k, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力して下さい。' }
  end
  validates :birth_day, presence: true
end
