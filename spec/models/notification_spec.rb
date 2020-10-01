require 'rails_helper'

RSpec.describe 'Notificationモデル', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Visiterモデル(User)との関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
      end
    end

    context 'Visitedモデル(User)との関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end

    context 'Diaryモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:diary).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end
  end
end
