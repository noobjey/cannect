require 'rails_helper'
require 'support/login_helper'

RSpec.feature "GithubServices:", type: :feature do
  include LoginHelper

  before do
    @user    ||= create_github_user
    @github_service = GithubService.new(@user)
  end

  xit "#profile" do
    VCR.use_cassette("github user info") do
      expect(@github_service.profile.id.to_s).to eq(omniauth_github_return.uid)
      expect(@github_service.profile.avatar_url).to eq(profile_info[:avatar_url])
      expect(@github_service.profile.following).to eq(profile_info[:following])
    end
  end
end
