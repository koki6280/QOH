require 'rails_helper'

RSpec.describe 'Favoriteモデル', type: :model do
	describe 'アソシエーションのテスト' do
	    context 'Userモデルとの関係' do
	      it 'N:1となっている' do
	        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
	      end
	    end

	    context 'Diaryモデルとの関係' do
	      it 'N:1となっている' do
	        expect(Favorite.reflect_on_association(:diary).macro).to eq :belongs_to
	      end
	    end
	end
end