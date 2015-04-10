require 'rubygems'
require 'twitter'

#証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#参照
#http://stackoverflow.com/questions/17076988/ruby-gem-twitter-certificate-verify-failed-twittererrorclienterror
#http://qiita.com/shimoju/items/394818b4989b94680aaf
#http://www.mk-mode.com/octopress/2013/12/02/ruby-gem-twitter-failure/


client = Twitter::REST::Client.new do |config|
  config.consumer_key       = "consumerKey"
  config.consumer_secret    = "consumerSecret"
  config.access_token        = "token"
  config.access_token_secret = "tokenSecret"
end

client.update("Rubyからpost")
