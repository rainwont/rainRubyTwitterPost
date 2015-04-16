require 'rubygems'
require 'twitter'

API_KEY             = 'xxxx'
API_SECRET          = 'xxxx'
ACCESS_TOKEN        = 'xxxx'
ACCESS_TOKEN_SECRET = 'xxxx'

def gettl
  client = Twitter::REST::Client.new do |keys|
    keys.consumer_key         = API_KEY
    keys.consumer_secret      = API_SECRET
    keys.access_token         = ACCESS_TOKEN
    keys.access_token_secret  = ACCESS_TOKEN_SECRET
  end

  user_name = []
  user_screen_name = []
  text = []

  i = 0
  client.home_timeline.reverse_each do |status|
    user_name[i]        = "#{status.user.name}"
    user_screen_name[i] = "#{status.user.screen_name}"
    text[i]             = "#{status.text}"
    i += 1
  end

  j = 0
  count = user_name.size
  count.times do |j|
    puts "#{user_name[j]} @#{user_screen_name[j]}"
    puts text[j]
    puts '---------------------------------------------'
    j += 1
  end
end

# 証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

gettl()
