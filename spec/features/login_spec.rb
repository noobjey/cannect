require "rails_helper"
require "support/login_helper"

RSpec.feature "Logins:", type: :feature do
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

      it "sees a twitter login button" do
        expect(current_path).to eq root_path
        expect(page).to have_link login_button("twitter")
      end

      context "can login" do
        before do
          create_services()
        end

        it "with github" do
          stub_omniauth_github()
          click_on login_button("github")

          expect(current_path).to eq dashboard_path
          expect(page).to have_link logout_button
        end

        it "with twitter" do
          stub_omniauth_twitter()
          click_on login_button("twitter")

          expect(current_path).to eq dashboard_path
          expect(page).to have_link logout_button
        end
      end
    end

    context "and is logged in" do
      before do
        create_services()
        stub_omniauth_twitter()
        login_user("twitter")
      end

      it "is sent to the dashboard" do
        visit root_path

        expect(current_path).to eq(dashboard_path)
      end
    end
  end

  describe "a user that visits the dashboard page" do

    context "and is not logged in" do
      it "is sent to the login page" do
        visit dashboard_path

        expect(current_path).to eq(root_path)
      end
    end

    context "and is logged in" do
      before do
        create_services()
        stub_omniauth_twitter()
        login_user("twitter")
      end

      it "can logout" do
        click_on logout_button()

        expect(current_path).to eq(root_path)
      end
    end
  end
end
