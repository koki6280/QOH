require 'rails_helper'

RSpec.describe 'Commentモデル', type: :model do
	describe 'バリデーション' do
	  let(:user) { create(:user) }
      let(:diary) { create(:diary, user_id: user.id) }
      let(:comment) { create(:comment, user_id: user.id, diary_id: diary.id) }
      subject { comment.valid? }
       
       it '作成できること' do
	         is_expected.to eq true
	   end

	   	context 'commentカラム' do
		      it '空欄でないこと' do
		        comment.comment = ''
		        is_expected.to eq false
		      end

		      it "200文字以内であること" do
		        comment.comment = Faker::Lorem.characters(number:201)
		        is_expected.to eq false
		      end
	    end
	end

  describe 'アソシエーションのテスト' do
	    context 'Userモデルとの関係' do
	      it 'N:1となっている' do
	        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
	      end
	    end

	    context 'Diaryモデルとの関係' do
	      it 'N:1となっている' do
	        expect(Comment.reflect_on_association(:diary).macro).to eq :belongs_to
	      end
	    end

	    context 'Notificationモデルとの関係' do
	      it '1:Nとなっている' do
	        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
	      end
	    end
  end
end