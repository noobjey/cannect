class GithubService
  attr_reader :client

  def initialize(authorization)
    @client = Octokit::Client.new(access_token: authorization.token)
  end

  def follow(username)
    client.follow(username)
  end

  def unfollow(username)
    client.unfollow(username)
  end

end
