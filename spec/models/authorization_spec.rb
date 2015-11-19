require "rails_helper"
require "support/login_helper"

RSpec.describe Authorization, type: :model do
  include LoginHelper

  describe "Authorization:" do

    attr_reader :authorization

    before do
      create_services()
      @authorization = Authorization.create(
        provider: omniauth_twitter_return.provider,
        uid:      omniauth_twitter_return.uid,
        token:    omniauth_twitter_return.credentials.token,
        user_id:  omniauth_twitter_return.uid,
        secret:   omniauth_twitter_return.credentials.secret,
        username: omniauth_twitter_return.info.nickname
      )
    end

    it "#find_from_oauth" do
      auth = Authorization.find_from_oauth(omniauth_twitter_return)

      expect(auth).to eq(authorization)
    end

    it "#create_from_user_and_oauth" do
      user = User.create(name: "a name")

      auth = Authorization.create_from_user_and_oauth(user, omniauth_twitter_return)

      expect(auth.user_id).to eq(user.id)
      expect(auth.provider).to eq(omniauth_twitter_return.provider)
    end

    it "#logo_for_service" do
      service = Service.find_by(provider: omniauth_twitter_return.provider)

      expect(authorization.logo_for_service).to eq(service.logo)
    end
  end
end
