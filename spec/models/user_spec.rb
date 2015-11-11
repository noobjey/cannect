require 'rails_helper'
require 'support/login_helper'

RSpec.describe User, type: :model do
  include LoginHelper

  describe '#find_or_create_from_oauth' do

    context 'when uid does not exit' do
      it 'create user' do
        expect(User.count).to eq(0)

        user = User.find_or_create_from_oauth(omniauth_github_return)

        expect(User.count).to eq(1)
        expect(user.uid).to eq(omniauth_github_return.uid)
        expect(user.provider).to eq(omniauth_github_return.provider)
        expect(user.username).to eq(omniauth_github_return.extra.raw_info.login)
        expect(user.token).to eq(omniauth_github_return.credentials.token)
      end
    end

    context 'when uid exists' do
      it 'return user' do
        User.create(uid: omniauth_github_return.uid)

        user = User.find_or_create_from_oauth(omniauth_github_return)

        expect(User.count).to eq(1)
        expect(user.uid).to eq(omniauth_github_return.uid)
      end
    end
  end
end
