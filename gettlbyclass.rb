require 'rubygems'
require 'twitter'
require 'pp'


API_KEY             = 'xxxx'
API_SECRET          = 'xxxx'
ACCESS_TOKEN        = 'xxxx'
ACCESS_TOKEN_SECRET = 'xxxx'


class Timeline

# confirm 認証
  def confirm
    @client = Twitter::REST::Client.new do |keys|
      keys.consumer_key        = API_KEY
      keys.consumer_secret     = API_SECRET
      keys.access_token        = ACCESS_TOKEN
      keys.access_token_secret = ACCESS_TOKEN_SECRET
    end
  end

# gettl TLの取得
  def gettl
    @user_name        = []
    @user_screen_name = []
    @text             = []

    i = 0
    @client.home_timeline.each do |status|
      @user_name[i]         = "#{status.user.name}"
      @user_screen_name[i]  = "#{status.user.screen_name}"
      @text[i]              = "#{status.text}"
      i += 1
    end
  end

# viewtl TLの表示
  def viewtl
    @user_name.reverse!
    @user_screen_name.reverse!
    @text.reverse!

    (0..19).each do |j|
      puts "#{@user_name[j]} @#{@user_screen_name[j]}"
      puts @text[j]
      puts '----------------------------------------------'
    end
  end

end


#証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

tc = Timeline.new
tc.confirm        #認証
tc.gettl          #TL取得
tc.viewtl         #TL表示
