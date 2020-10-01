require 'rails_helper'

RSpec.describe '表示のテスト', type: :feature do
  subject { page }

  let(:current_user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:diary) { create(:diary, user_id: current_user.id) }

  before do
    visit new_user_session_path
  end

  describe 'リンク表示のテスト' do
    context '会員登録リンク' do
      it 'ログインしていなければ表示される' do
        is_expected.to have_link '会員登録'
      end
      it 'ログインしていれば表示されない' do
        login(current_user)
        is_expected.not_to have_link '会員登録'
      end
    end

    context 'ログインリンク' do
      it 'ログインしていなければ表示される' do
        is_expected.to have_link 'ログイン'
      end
      it 'ログインしていれば表示されない' do
        login(current_user)
        is_expected.not_to have_link 'ログイン'
      end
    end

    context 'マイページリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'マイページ'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'マイページ'
      end
    end

    context '新規投稿リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '新規投稿'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '新規投稿'
      end
    end

    context '投稿一覧リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '投稿一覧'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '投稿一覧'
      end
    end

    context '通知リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '通知'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '通知'
      end
    end

    context 'ログアウトリンクリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'ログアウト'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'ログアウト'
      end
    end

    context 'プロフィール編集リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'プロフィール編集'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'プロフィール編集'
      end
    end

    context 'カレンダー詳細リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'カレンダー詳細'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'カレンダー詳細'
      end
    end

    context 'グラフ詳細リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'グラフ詳細'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'グラフ詳細'
      end
    end

    context 'お気に入りの日記リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'お気に入りの日記'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'お気に入りの日記'
      end
    end
  end

  describe 'ボタン表示のテスト' do
    context 'プロフィール編集ボタン' do
      it 'マイページであれば表示される' do
        login(current_user)
        visit user_path(current_user)
        is_expected.to have_link 'プロフィール編集'
      end
      it 'マイページでなければ表示されない' do
        login(another_user)
        visit user_path(current_user)
        is_expected.not_to have_link 'プロフィール編集'
      end
    end

    context 'フォローボタン' do
      it 'マイページであれば表示されない' do
        login(current_user)
        visit user_path(current_user)
        is_expected.not_to have_link 'フォローする'
      end
      it 'マイページでなければ表示される' do
        login(another_user)
        visit user_path(current_user)
        is_expected.to have_link 'フォローする'
      end
    end

    context 'メッセージボタン' do
      it 'マイページであれば表示されない' do
        login(current_user)
        visit user_path(current_user)
        is_expected.not_to have_button 'メッセージ'
      end
      it 'マイページでなければ表示される' do
        login(another_user)
        visit user_path(current_user)
        is_expected.to have_button 'メッセージ'
      end
    end

    context 'Diary編集ボタン(アイコン)' do
      it '自分が投稿した日記であれば表示される' do
        login(current_user)
        visit diary_path(diary)
        is_expected.to have_link '', href: edit_diary_path(diary)
      end
      it '自分が投稿した日記でなければ表示されない' do
        login(another_user)
        visit diary_path(diary)
        is_expected.not_to have_link '', href: edit_diary_path(diary)
      end
    end

    context 'Diary削除ボタン(アイコン)' do
      it '自分が投稿した日記であれば表示される' do
        login(current_user)
        visit diary_path(diary)
        is_expected.to have_link ''
      end
      it '自分が投稿した日記でなければ表示されない' do
        login(another_user)
        visit diary_path(diary)
        is_expected.not_to have_link '', href: diary_path(diary)
      end
    end
  end
end
