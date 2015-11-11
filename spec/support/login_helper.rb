module LoginHelper

  def stub_omniauth_github
    OmniAuth.config.test_mode          = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
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
                                                                  }
                                                                })
  end

end
