require 'rails_helper'

RSpec.describe 'Messageモデル', type: :model do
  describe 'バリデーション' do
    subject { message.valid? }

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let(:message) { create(:message, user_id: user.id, room_id: room.id) }

    it '作成できること' do
      is_expected.to eq true
    end

    context 'body' do
      it '空欄でないこと' do
        message.body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        message.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
