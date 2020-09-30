require 'rails_helper'

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:diary) { create(:diary, user: user) }
  let!(:diary2) { create(:diary, user: user2) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe 'サイドバーのテスト' do
    context '表示の確認' do
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it '名前が表示される' do
        expect(page).to have_content(user.nickname)
      end
      it '自己紹介が表示される' do
        expect(page).to have_content(user.profile)
      end
      it '編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
      end
      it 'フォローリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: user_follows_path(user)
      end
      it 'フォロワーリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: user_followers_path(user)
      end
      it 'お気に入りの日記リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: user_favorites_path(user)
      end
      it 'カレンダー詳細リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: my_calendar_path
      end
    end
  end
end