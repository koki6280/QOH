require 'rails_helper'

RSpec.describe '投稿認証のテスト', type: :feature do

  describe '投稿のテスト' do
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:diary) { create(:diary, user: user) }
    let!(:diary2) { create(:diary, user: user2) }
    let!(:comment) { create(:comment, user: user, diary: diary) }
    let!(:comment2) { create(:comment, user: user2, diary: diary2) }



    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    describe '編集のテスト' do
        context '自分の投稿の編集画面への遷移' do
            it '遷移できる' do
              visit edit_diary_path(diary)
              expect(current_path).to eq('/diaries/' + diary.id.to_s + '/edit')
            end
        end

        context '他人の投稿の編集画面への遷移' do
            it '遷移できない' do
              visit edit_diary_path(diary2)
              expect(current_path).to eq('/diaries')
            end
        end
    end

    describe '一覧画面のテスト' do
        before do
          visit diaries_path
        end

        context '表示の確認' do
            it '投稿一覧と表示される' do
              expect(page).to have_content '投稿一覧'
            end
            it '自分と他人の画像のリンク先が正しい' do
              expect(page).to have_link '', href: diary_path(diary)
              expect(page).to have_link '', href: diary_path(diary2)
            end
            it '自分と他人の『コメントする』のリンク先が正しい' do
              expect(page).to have_link 'コメントする', href: diary_path(diary)
              expect(page).to have_link 'コメントする', href: diary_path(diary2)
            end
        end
    end

    describe '詳細画面のテスト' do
        context '自分・他人共通の投稿詳細画面の表示を確認' do
            it 'ユーザー画像・名前のリンク先が正しい' do
              visit diary_path(diary)
              expect(page).to have_link diary.user.nickname, href: user_path(diary.user)
            end
            it '投稿のopinionが表示される' do
              visit diary_path(diary)
              expect(page).to have_content diary.body
            end
        end
      
        context '自分の投稿詳細画面の表示を確認' do
            it '投稿の編集アイコンが表示される' do
              visit diary_path diary
              expect(page).to have_link '', href: edit_diary_path(diary)
            end
            it '投稿の削除アイコンが表示される' do
              visit diary_path diary
              expect(page).to have_link '', href: diary_path(diary)
            end
        end
      
        context '他人の投稿詳細画面の表示を確認' do
            it '投稿の編集アイコンが表示されない' do
              visit diary_path(diary2)
              expect(page).to have_no_link '', href: edit_diary_path(diary2)
            end
            it '投稿の削除アイコンが表示されない' do
              visit diary_path(diary2)
              expect(page).to have_no_link '', href: diary_path(diary2)
            end
        end
    end
  end
end