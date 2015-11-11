require 'rails_helper'

RSpec.feature "Logins:", type: :feature do
  include Capybara::DSL

  before do
    Capybara.app = Cannect::Application
  end

  describe "a user that visits the login page" do
    let(:login_button) { "Login with Github" }

    before do
      visit root_path
    end

    context "and is not logged in" do
      it "sees a login button" do
        expect(current_path).to eq root_path
        expect(page).to have_link login_button
      end
    end
  end
end
