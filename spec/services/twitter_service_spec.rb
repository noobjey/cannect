require "rails_helper"
require "support/login_helper"

RSpec.feature "TwitterServices:", type: :feature do
  include LoginHelper
  attr_reader :authorization, :service

  before do
    @authorization = Authorization.create(
      provider: omniauth_twitter_return.provider,
      uid:      omniauth_twitter_return.uid,
      token:    omniauth_twitter_return.credentials.token,
      secret:   omniauth_twitter_return.credentials.secret,
      user_id: 1,
      username: omniauth_twitter_return.info.nickname
    )

    @service      = TwitterService.new(authorization)
  end

  it "#following", focus: true do
    VCR.use_cassette("twitter") do
      expect(service.following()).to eq(65)
    end
  end
  
end
