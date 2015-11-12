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

  context "and is logged in" do
    before do
      login_user()
      expect(current_path).to eq(dashboard_path)
    end

    it "can logout" do
      expect(page).to have_link(logout_button)

      click_on logout_button

      expect(current_path).to eq(root_path)
    end

    it "sees github username" do
      within "nav" do
        expect(page).to have_content(user.username)
        expect(page).to have_css("img[src*='Octocat.jpg']")
      end
    end
  end
end
