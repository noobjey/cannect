require "rails_helper"
require "support/login_helper"

RSpec.describe ServiceFactory, type: :model do
  include LoginHelper

  describe "ServiceFactory:" do

    it "#create_service" do
      user = User.create(name: "logged in user")
      service_name = "github"
      user.authorizations << Authorization.create(uid: "uid", provider: service_name)

      service = ServiceFactory.create_service(user, service_name)

      expect(service.class).to eq(GithubService)
    end
  end
end
