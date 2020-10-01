require 'rails_helper'

RSpec.describe 'Eventモデル', type: :model do
  describe 'バリデーション' do
    subject { event.valid? }

    let(:user) { create(:user) }
    let(:event) { create(:event, user_id: user.id) }

    it '作成できること' do
      is_expected.to eq true
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        event.title = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        event.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'event_bodyカラム' do
      it '空欄でないこと' do
        event.event_body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        event.event_body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'start_date' do
      it '空欄でないこと' do
        event.start_date = ''
        is_expected.to eq false
      end
    end

    context 'end_date' do
      it '空欄でないこと' do
        event.end_date = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
