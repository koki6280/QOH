require 'rails_helper'

RSpec.describe '認証のテスト', type: :feature do
  let(:user) { create(:user) }
  subject { page }

  describe 'ユーザー認証のテスト' do
    context '新規会員登録のテスト' do
      it '新規会員登録できること' do
        visit new_user_registration_path
        fill_in 'ニックネーム', with: Faker::Lorem.characters(number: 5)
        fill_in 'メールアドレス', with: Faker::Internet.free_email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認用)', with: 'password'
        click_button '新規登録'
        is_expected.to have_content 'ログアウト'
      end

      it '新規会員登録できないこと' do
        visit new_user_registration_path
        fill_in 'ニックネーム', with: Faker::Lorem.characters(number: 5)
        fill_in 'メールアドレス', with: Faker::Internet.free_email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認用)', with: 'aaaaaaaa'
        click_button '新規登録'
        is_expected.to have_content '新規登録'
      end
    end

    context 'ユーザーログインのテスト' do
      it 'ログインできること' do
        visit new_user_session_path
        login(user)
        is_expected.to have_content 'ログアウト'
      end

      it 'ログインできないこと' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'aaaaaaaa'
        click_button 'ログイン'
        is_expected.to have_content 'ログイン'
      end
    end

    context 'ユーザーログアウトのテスト' do
      it 'ログアウトできること' do
        visit new_user_session_path
        login(user)
        click_link 'ログアウト'
        is_expected.to have_content 'ログイン'
      end
    end


  end
end