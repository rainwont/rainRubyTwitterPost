require 'rubygems'
require 'twitter'
require 'yaml'

config = YAML.load_file 'config.yml'

#証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$client = Twitter::REST::Client.new do |keys|
  keys.consumer_key        = config["twitter"]["consumer_key"]
  keys.consumer_secret     = config["twitter"]["consumer_secret"]
  keys.access_token        = config["twitter"]["access_token"]
  keys.access_token_secret = config["twitter"]["access_token_secret"]
end

class Timeline

  def get_name_text
    timeline = $client.home_timeline   # タイムライン取得
      timeline.each do |status|
        user_name =   "#{status.user.name}"
        text      =   "#{status.text}"
        print "#{user_name}\t"
        puts text
        puts '--------------------------------------'
      end
  end
end

rainwont_client = Timeline.new
rainwont_client.get_name_text
