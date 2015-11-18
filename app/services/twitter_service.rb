
class TwitterService
  attr_reader :client
  def initialize(authorization)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Figaro.env.twitter_key
      config.consumer_secret = Figaro.env.twitter_secret
      config.access_token        = authorization.token
      config.access_token_secret = authorization.secret
    end

  end

  def follow(username)
    client.follow(username)
  end

  def unfollow(username)
    client.unfollow(username)
  end

end
