module LoginHelper

  include Capybara::DSL
  Capybara.app = Cannect::Application

  def stub_omniauth_github
    OmniAuth.config.test_mode          = true
    OmniAuth.config.mock_auth[:github] = omniauth_github_return
  end

  def stub_omniauth_twitter
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = omniauth_twitter_return
  end

  def omniauth_github_return
    OmniAuth::AuthHash.new({
                             provider:    "github",
                             uid:         "8325508",
                             info:        {
                               nickname: "noobjey",
                               name:     "Jason Wright",
                               image:    "https://avatars.githubusercontent.com/u/8325508?v=3",
                             },
                             credentials: {
                               token:    "d088f5075d8e264517cee9665f0f3659a92c3744"
                             }
                           })
  end

  def omniauth_twitter_return
    OmniAuth::AuthHash.new({
                             provider:    "twitter",
                             uid:         "84891952",
                             info:        {
                               nickname: "noobjey",
                               name:     "Jason Wright",
                               image:    "http://pbs.twimg.com/profile_images/488101956/noobjEdit_normal.jpg",
                             },
                             credentials: {
                               token:  "84891952-bksp0deuwkSrwTVyDuZw6UVfefWlJfRM8MmJ5JgdB",
                               secret: "0eTvsoZjAX9xXkVBXkjg0EXhjINeJfaCsJDrwvE2JK3f9"
                             }
                           })
  end

  def profile_info
    {
      avatar_url: "https://avatars.githubusercontent.com/u/8325508?v=3",
      following:  10
    }
  end

  def login_user(service = "github")
    visit root_path
    click_on login_button(service)
  end

  def login_button(service)
    "Login with #{service.capitalize}"
  end

  def logout_button()
    "Logout"
  end

  def create_github_user()
    User.find_or_create_from_oauth(omniauth_github_return)
  end

  def create_services()
    Service.create(provider: omniauth_github_return.provider, logo: omniauth_github_return.info.image)
    Service.create(provider: omniauth_twitter_return.provider, logo: omniauth_twitter_return.info.image)
  end

  def logo_for_service(service = "github")
    Service.find_by(provider: service).logo
  end
end
