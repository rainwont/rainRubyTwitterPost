require 'rubygems'
require 'twitter'
require 'kconv' # UTF-8 を Shift-Jis に変換するライブラリ

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

##POST
#client.update("Rubyからpost")
#client.update ARGV[0]

##タイムライン取得
timeline = client.home_timeline  #タイムラインを取得
timeline.each{ |status|
  str = "(#{status.user.screen_name}) #{status.text}"
  puts str.kconv(Kconv::SJIS, Kconv::UTF8)
}
