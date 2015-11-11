module LoginHelper

  include Capybara::DSL
  Capybara.app = Cannect::Application

  def stub_omniauth_github
    OmniAuth.config.test_mode          = true
    OmniAuth.config.mock_auth[:github] = omniauth_github_return
  end

  def omniauth_github_return
    OmniAuth::AuthHash.new({
                             provider:    "github",
                             uid:         "8325508",
                             info:        {
                               nickname: "noobjey",
                               email:    "noobjey@gmail.com",
                               name:     "Jason Wright",
                               image:    "https://avatars.githubusercontent.com/u/8325508?v=3",
                               urls:     {
                                 GitHub: "https://github.com/noobjey",
                               }
                             },
                             credentials: {
                               token:    "d088f5075d8e264517cee9665f0f3659a92c3744",
                               expiresß: false
                             },
                             extra:       {
                               raw_info: {
                                 login: "noobjey"
                               }
                             }
                           })
  end

  def login_user()
    visit login_path
  end

  def login_button()
    "Login with Github"
  end

  def logout_button()
    "Logout"
  end
end
