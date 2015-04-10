require 'rubygems'
require 'twitter'
require 'yaml'

config = YAML.load_file 'config.yml'

#証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#参照
#http://stackoverflow.com/questions/17076988/ruby-gem-twitter-certificate-verify-failed-twittererrorclienterror
#http://qiita.com/shimoju/items/394818b4989b94680aaf
#http://www.mk-mode.com/octopress/2013/12/02/ruby-gem-twitter-failure/


client = Twitter::REST::Client.new do |keys|
  keys.consumer_key        = config["twitter"]["consumer_key"]
  keys.consumer_secret     = config["twitter"]["consumer_secret"]
  keys.access_token        = config["twitter"]["access_token"]
  keys.access_token_secret = config["twitter"]["access_token_secret"]
end


##POST
#client.update("Rubyからpost")
#client.update ARGV[0]


##タイムライン取得
timeline = client.home_timeline  #タイムラインを取得
timeline.each do |status|
  str = "(#{status.user.screen_name}) #{status.text}"
  puts str
end
