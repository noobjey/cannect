require "rails_helper"
require "support/login_helper"

RSpec.describe User, type: :model do
  include LoginHelper

  describe "User:" do

    attr_reader :user, :service

    before do
      create_services()
      @user = User.create_from_oauth(omniauth_github_return)
      @service = Service.find_by(provider: "github")
    end

    it "#create_from_oauth" do
      expect(User.count).to eq(1)
      expect(user.name).to eq(omniauth_github_return.info.name)
      expect(user.image_url).to eq(omniauth_github_return.info.image)

      expect(user.services.count).to eq(1)
      expect(user.services.first.provider).to eq(omniauth_github_return.provider)
    end

    it "#inactive_services" do
      user.services << service

      expect(user.inactive_services().first.provider).to eq("twitter")
    end

    it "#username for service" do
      user.authorizations << Authorization.create(
        user_id: user.id,
        uid:     omniauth_github_return.uid,
        provider: omniauth_github_return.provider,
        username: omniauth_github_return.info.nickname
      )

      expect(user.username_for_service(service)).to eq(omniauth_github_return.info.nickname)
    end

    it "#add_new_service" do
      expect(user.services.count).to eq(1)
      user.add_new_service(omniauth_twitter_return)

      expect(user.services.count).to eq(2)
    end
  end
end
