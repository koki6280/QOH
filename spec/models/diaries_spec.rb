require 'rails_helper'

RSpec.describe 'Diaryモデル', type: :model do
  describe 'バリデーション' do
    subject { diary.valid? }

    let(:user) { create(:user) }
    let!(:diary) { build(:diary, user_id: user.id) }

    it '作成できること' do
      is_expected.to eq true
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        diary.body = ''
        is_expected.to eq false
      end

      it "200文字以内であること" do
        diary.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'exerciseカラム' do
      it '空欄でないこと' do
        diary.exercise = ''
        is_expected.to eq false
      end
    end

    context 'sleepカラム' do
      it '空欄でないこと' do
        diary.sleep = ''
        is_expected.to eq false
      end
    end

    context 'cigarette' do
      it '空欄でないこと' do
        diary.cigarette = ''
        is_expected.to eq false
      end
    end

    context 'drinking' do
      it '空欄でないこと' do
        diary.drinking = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Diary.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Diary.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
