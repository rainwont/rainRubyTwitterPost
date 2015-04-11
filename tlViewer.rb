require 'rubygems'
require 'tweetstream'

API_KEY             = 'xxxxx'
API_SECRET          = 'xxxxx'
ACCESS_TOKEN        = 'xxxxx'
ACCESS_TOKEN_SECRET = 'xxxxx'

TweetStream.configure do |config|
	config.consumer_key = API_KEY
	config.consumer_secret = API_SECRET
	config.oauth_token = ACCESS_TOKEN
	config.oauth_token_secret = ACCESS_TOKEN_SECRET
	config.auth_method = :oauth
end

puts "認証かくにん！よかった"


# tweetstream使用
client = TweetStream::Client.new

# 稼働時の処理（ここではサーバ接続したことを表示）
client.on_inited do
  puts '接続処理...TL取得に10秒かかる・・・はず'
end

EM.run do
  EM::PeriodicTimer.new(10) do
#    puts Time.now
  end

  client.userstream do |object|
    puts "recieve a tweet / class: #{object.class}"
		print object.user.name
		print ' @'
		puts object.user.screen_name
    puts object.text

  end
end
