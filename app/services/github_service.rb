class GithubService
  attr_reader :client

  def initialize(user)
    @client = Octokit::Client.new(access_token: user.token)
  end

  def profile
    profile_info
  end


  private

  def profile_info
    @profile_info ||= client.user
  end
end
