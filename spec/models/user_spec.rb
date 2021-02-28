require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '値が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailがすでに登録されていると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it "emailに\b@が含まれていないと登録できない" do
      @user.email = 'testgmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordとpassword_confirmationが６文字以上で半角英数字混合であれば登録できる' do
      @user.password = '123456a'
      @user.password_confirmation = '123456a'
      expect(@user).to be_valid
    end

    it 'passwordが空では登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが５文字以下だと登録できない' do
      @user.password = '1234a'
      @user.password_confirmation = '1234a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合でないと登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password 英字と数字の両方を含めて設定してください')
    end

    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @user.password = '123456a'
      @user.password_confirmation = '1234567a'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
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

    it 'family_nameが、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.family_name = 'as'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
    end

    it 'first_nameが、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = 'as'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
    end

    it 'family_name_kanaが空では登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end

    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'family_name_kanaが全角（カタカナ）でないと登録できない' do
      @user.family_name_kana = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana 全角カナ文字を使用してください')
    end

    it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
      @user.first_name_kana = '花子'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カナ文字を使用してください')
    end

    it 'birth_dateが空では登録できない' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
