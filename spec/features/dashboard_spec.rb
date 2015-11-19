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
    create_services()
    stub_omniauth_github()
  end

  context "a logged in user" do
    before do
      login_user()
      expect(current_path).to eq(dashboard_path)
    end

    it "sees github profile picture in profile" do
      within "#profile" do
        expect(first("img")[:src]).to eq(omniauth_github_return.info.image)
      end
    end

    it "sees github username in profile" do
      within "#profile" do
        expect(page).to have_content(omniauth_github_return.info.name)
        expect(page).to have_css("img[src*='#{logo_for_service()}']")
      end
    end

    xit "sees number of github followers" do
      within "#profile" do
        expect(page).to have_content("Following: #{profile_info[:following]}")
      end
    end
  end
end
