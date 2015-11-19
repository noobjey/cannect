require "rails_helper"
require "support/login_helper"

RSpec.feature "Dashboard Profile:", type: :feature do
  include LoginHelper

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
      end
    end

    xit "sees number of github followers" do
      within "#profile" do
        expect(page).to have_content("Following: #{profile_info[:following]}")
      end
    end

    it "sees services logos" do
      within "#profile" do
        expect(page).to have_css("img[src*='#{logo_for_service("github")}']")
        expect(page).to have_css("img[src*='#{logo_for_service("twitter")}']")
      end
    end
  end

  context "a user who has only regestered one service" do
    before do
      stub_omniauth_twitter()
      login_user("twitter")
    end

    it "can login again with that service" do
      click_on "Logout"
      expect(current_path).to eq(root_path)

      login_user("twitter")
      expect(current_path).to eq(dashboard_path)

      within "#profile" do
        within first(".collection-item.row") do
          expect(page).not_to have_link(add_service_button())
          expect(page).to have_css("img[src*='#{logo_for_service("twitter")}']")
        end
      end
    end

    it "sees their username by the registered servcie" do
      within "#profile" do
        within first(".collection-item.row") do
          expect(page).to have_content(omniauth_twitter_return.info.nickname)
          expect(page).to have_css("img[src*='#{logo_for_service("twitter")}']")
        end
      end
    end

    it "sees the add button by the unregistered servcie" do
      within "#profile" do
        within (".collection-item:nth-of-type(3)") do
          expect(page).to have_link(add_service_button())
          expect(page).to have_css("img[src*='#{logo_for_service("github")}']")
        end
      end
    end


    it "can add uregistered servcie" do
      within "#profile" do
        within (".collection-item:nth-of-type(3)") do
          stub_omniauth_github()
          expect(page).to have_link(add_service_button())
          click_on add_service_button()
        end
      end

      within "#profile" do
        within (".collection-item:nth-of-type(3)") do
          expect(page).to have_content(omniauth_github_return.info.nickname)
        end
      end
    end
  end
end
