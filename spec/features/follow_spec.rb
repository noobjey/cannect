require "rails_helper"
require "support/login_helper"

RSpec.feature "Follows:", type: :feature do
  include LoginHelper

  describe "a user that visits the dashboard" do

    let!(:user) { User.create(
      name:      omniauth_github_return.info.name,
      image_url: omniauth_github_return.info.image
    ) }

    let!(:group) { Group.create(
      name:        "group1",
      description: "big group",
      owner_id:    user.id
    ) }

    before do
      create_services()
      stub_omniauth_github()
      login_user()
      group.users << user
      user.services << Service.find_by_provider("github")
    end

    it "sees all groups" do
      within "#groups" do
        expect(find_all(".group-row").count).to eq(1)

        within ".group-row" do
          expect(page).to have_css("img[src*='#{user.image_url}']")
          expect(page).to have_content(user.name)
          expect(page).to have_content(group.name)
          expect(page).to have_content(group.description)
          expect(page).to have_content(group.users.count)
          expect(page).to have_button("add_circle")
          expect(page).to have_button("remove_circle")
        end
      end
    end

    it "sees a user in a groups details" do
      within "#groups" do
        expect(page).to have_css("img[src*='#{user.image_url}']")
        expect(page).to have_content(user.name)

        expect(page).to have_css("img[src*='#{user.services.first.logo}']")

        expect(page).to have_button("add_circle")
        expect(page).to have_button("remove_circle")
      end
    end

    it "sees greyed out follow buttons if they are the current user" do
      within "#groups" do
        find_button("add_circle")["class"].include?("disabled")
        find_button("remove_circle")["class"].include?("disabled")
      end
    end
  end
end
