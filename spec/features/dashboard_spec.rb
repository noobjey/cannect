require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Dashboard:", type: :feature do
  include LoginHelper

  let(:login_button) { "Login with Github" }
  let(:logout_button) { "Logout" }

  before do
    stub_omniauth_github()
  end

  context "and is logged in" do
    before do
      login_user()
      expect(current_path).to eq(dashboard_path)
    end

    it "can logout" do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link(logout_button)

      click_on logout_button

      expect(current_path).to eq(root_path)
    end
  end
end
