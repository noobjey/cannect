require "rails_helper"
require "support/login_helper"

RSpec.feature "Profile Groups:", type: :feature do
  include LoginHelper

  let(:group1_name) { "group 1" }
  let(:group1_description) { "group 1 description" }
  let!(:other_user) { User.create(name: "Other User", image_url: "link to image") }

  describe "a logged in user" do
    before do
      create_services()
      stub_omniauth_github()
      login_user()
    end

    context "with no owned groups" do

      it "can create a new group" do
        click_create_group_button_on_dashboard()
        expect(current_path).to eq(new_group_path)
        fill_out_new_group_form(group1_name, group1_description)
        click_on create_group_button()

        within "#owned-groups" do
          within ".collection-item:nth-of-type(2)" do
            expect(page).to have_content(group1_name)
            expect(page).to have_link("Edit")
            expect(page).to have_link("Remove")
          end
        end
      end
    end

    context "with an owned group" do
      before do
        visit dashboard_path
        click_create_group_button_on_dashboard()
        fill_out_new_group_form()
        click_on create_group_button()
      end

      it "can edit the group" do
        new_name        = "new name"
        new_description = "new description"

        within "#owned-groups" do
          within ".collection-item:nth-of-type(2)" do
            expect(page).to have_link(edit_group_button())
            click_on edit_group_button()
          end
        end

        expect(current_path).to eq(edit_group_path(Group.first))
        expect(page).to have_button("Update Group")
        fill_out_new_group_form(new_name, new_description)
        click_on "Update Group"

        within "#owned-groups" do
          within ".collection-item:nth-of-type(2)" do
            expect(page).to have_content(new_name)
            expect(page).to have_link("Edit")
            expect(page).to have_link("Remove")
          end
        end
      end

      it "can remove a group" do
        within "#owned-groups" do
          within ".collection-item:nth-of-type(2)" do
            expect(page).to have_link("Remove")
            click_on "Remove"
          end
        end

        within "#owned-groups" do
          expect(page).not_to have_content("default name")
          expect(page).not_to have_link("Edit")
          expect(page).not_to have_link("Remove")
        end
      end
    end
  end


  private

  def fill_out_new_group_form(name = "default name", description = "default description")
    fill_in "Name", with: name
    fill_in "Description", with: description
    check(omniauth_github_return.info.name)
    check(other_user.name)
  end


  def click_create_group_button_on_dashboard
    within "#owned-groups" do
      expect(page).to have_link(create_group_button())
      click_link create_group_button()
    end
  end

end
