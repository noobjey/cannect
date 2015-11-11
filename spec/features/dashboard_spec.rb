require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Dashboard:", type: :feature do
  include LoginHelper

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
  end
end
