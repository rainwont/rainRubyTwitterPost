require 'rubygems'
require 'twitter'
require 'pp'
require 'kconv'


API_KEY             = 'xxxx'
API_SECRET          = 'xxxx'
ACCESS_TOKEN        = 'xxxx'
ACCESS_TOKEN_SECRET = 'xxxx'

class Timeline

  attr_accessor :posttext

  def initialize(mypost = "text")
    @posttext = mypost
  end


  def confirm
    @client = Twitter::REST::Client.new do |keys|
      keys.consumer_key        = API_KEY
      keys.consumer_secret     = API_SECRET
      keys.access_token        = ACCESS_TOKEN
      keys.access_token_secret = ACCESS_TOKEN_SECRET
    end
  end

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

  def viewtl
    @user_name.reverse!
    @user_screen_name.reverse!
    @text.reverse!

    (0..18).each do |j|
      puts "#{@user_name[j]} @#{@user_screen_name[j]}"
      puts @text[j]
      puts '----------------------------------------------'
    end
  end

  def post
    @client.update("#{@posttext} posted by ruby program.")
  end

end


# 証明を検証しない
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

tc = Timeline.new
tc.confirm
tc.gettl
tc.viewtl

# ツイートをPOST　引数がpostされる
text = ARGV[0]

if text != nil #引数あったらpost
  text.kconv(Kconv::UTF8, Kconv::SJIS)
  puts "投稿中..."
  posttext = Kconv.toutf8(text)

  tc.posttext = "#{posttext}"
  tc.post
  puts "投稿完了."
else
  # 引数なければ、postしない。なにもしない。
end
