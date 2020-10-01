require 'rails_helper'

RSpec.describe '認証のテスト', type: :feature do
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

    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end

      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_user_path(user2)
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end

      context '表示の確認' do
        before do
          visit edit_user_path(user)
        end

        it 'プロフィール編集と表示される' do
          expect(page).to have_content('プロフィール編集')
        end
        it '名前編集フォームに自分の名前が表示される' do
          expect(page).to have_field 'ネーム', with: user.nickname
        end
        it '自己紹介編集フォームに自分の自己紹介が表示される' do
          expect(page).to have_field '自己紹介', with: user.profile
        end
        it '編集に成功する' do
          click_button '登録'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
        it '編集に失敗する' do
          fill_in 'ネーム', with: ''
          click_button '登録'
          expect(page).to have_content 'ネーム を入力してください'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end
    end

    describe '詳細画面のテスト' do
      before do
        visit user_path(user)
      end

      context '表示の確認' do
        it '投稿一覧の日記の画像のリンク先が正しい' do
          expect(page).to have_link '', href: diary_path(diary)
        end
        it '『コメントする』のリンク先が正しい' do
          expect(page).to have_link 'コメントする', href: diary_path(diary)
        end
        it 'グラフ詳細のリンク先が正しい' do
          expect(page).to have_link 'グラフ詳細', href: user_graphs_path(user)
        end
      end
    end
  end
end
