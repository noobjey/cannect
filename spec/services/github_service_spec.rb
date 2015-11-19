require "rails_helper"
require "support/login_helper"

RSpec.feature "GithubServices:", type: :feature do
  include LoginHelper

  attr_reader :authorization, :service

  before do
    @authorization = Authorization.create(
      provider: omniauth_github_return.provider,
      uid:      omniauth_github_return.uid,
      token:    omniauth_github_return.credentials.token,
      user_id:  1,
      username: omniauth_github_return.info.nickname
    )

    @service = GithubService.new(authorization)
  end

  it "#following" do
    VCR.use_cassette("github") do
      expect(service.following()).to eq(11)
    end
  end
end
