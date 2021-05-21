require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー情報登録' do
      context "ユーザー情報が登録できるとき" do
        it 'nickname, email, password, password_confirmation, family_name, first_name, family_name_k, first_name_k, birth_dayが存在すれば登録できること ' do
          expect(@user).to be_valid
        end

        it 'passwordが6文字以上であれば登録できること' do
          @user.password = '1234ab'
          @user.password_confirmation = '1234ab'
          expect(@user).to be_valid
        end
      end

      context 'ユーザー情報が登録できないとき' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'passowrdが空では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'family_nameが空では登録できない' do
          @user.family_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name can't be blank")
        end

        it 'first_nameが空では登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'family_name_kが空では登録できない' do
          @user.family_name_k = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name k can't be blank")
        end

        it 'first_name_kが空では登録できない' do
          @user.first_name_k = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name k can't be blank")
        end

        it 'birth_dayが空では登録できない' do
          @user.birth_day = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth day can't be blank")
        end

        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = '123ab'
          @user.password_confirmation = '123ab'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = '1234ab'
          @user.password_confirmation = '9876cd'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordは、半角英語のみでは登録できない' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end

        it 'passwordは、半角数字のみでは登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end

        it 'passwordは、全角では登録できないこと' do
          @user.password = 'さくらももこ'
          @user.password_confirmation = 'さくらももこ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end

        it 'emailに@がなければ登録できないこと' do
          @user.email = 'testcom'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it '重複したemailが存在する場合登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
          @user.family_name = 'Shiga'
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name には全角（ひらがな、カタカナ、漢字）で入力してください")
        end

        it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
          @user.first_name = 'Takuma'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name には全角（ひらがな、カタカナ、漢字）で入力してください")
        end

        it 'ユーザー本名のフリガナは、全角（カタカナ）でなければ登録できないこと' do
          @user.family_name_k = 'しが'
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name k はカタカナで入力して下さい。")
        end

        it 'ユーザー本名のフリガナは、全角（カタカナ）でなければ登録できないこと' do
          @user.first_name_k = 'たくま'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name k はカタカナで入力して下さい。")
        end

        it 'ユーザー本名のフリガナが半角文字のとき登録できないこと' do
          @user.family_name_k = 'Shiga'
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name k はカタカナで入力して下さい。")
        end

        it 'ユーザー本名のフリガナが半角文字のとき登録できないこと' do
          @user.first_name_k = 'Takuma'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name k はカタカナで入力して下さい。")
        end
      end
    end
  end
end