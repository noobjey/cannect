require "rails_helper"
require "support/login_helper"

RSpec.feature "Follows:", type: :feature do
  include LoginHelper

  describe "a user that visits the login page" do
    before do
      visit root_path
    end

    context "and is not logged in" do
      it "sees a github login button" do
        expect(current_path).to eq root_path
        expect(page).to have_link login_button("github")
      end
    end
  end
end
