require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Dashboard:", type: :feature do
  include LoginHelper

  let(:user) { User.create(
    provider: omniauth_github_return.provider,
    uid:      omniauth_github_return.uid,
    username: omniauth_github_return.extra.raw_info.login,
    token:    omniauth_github_return.credentials.token
  ) }

  before do
    stub_omniauth_github()
  end

  context "a logged in user" do
    before do
      VCR.use_cassette('dashboard') do
        login_user()
        expect(current_path).to eq(dashboard_path)
      end
    end

    it "can logout" do
      expect(page).to have_link(logout_button)

      click_on logout_button

      expect(current_path).to eq(root_path)
    end

    it "sees github username in nav" do
      within "header" do
        expect(page).to have_content(user.username)
        expect(page).to have_css("img[src*='Octocat.jpg']")
      end
    end

    it "sees github profile picture in profile" do
      within "#profile" do
        expect(find("img")[:src]).to eq(profile_info[:avatar_url])
      end
    end

    it "sees number of github followers" do
      within "#profile" do
        expect(page).to have_content("Following: #{profile_info[:following]}")
      end
    end
  end
end
