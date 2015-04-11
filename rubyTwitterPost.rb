require 'rubygems'
require 'twitter'
require 'yaml'
require 'color_echo/get'  #コマンドラインに色をつける

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
  userName       = "#{status.user.name}"
  userScreenName = "#{status.user.screen_name}"
  text           = "#{status.text}"
#  userClient     = "#{status.source}"
#  rtCount        = "#{status.retweet_count}"
  favCount       = "#{status.favorite_count}"

#作ってみた（テスト中）
#ふぁぼの数だけ★を表示
#
#1の位は黄色★
#10ふぁぼで青色★１つ、20ふぁぼで青色★２つ・・・　
#
#100ふぁぼ以上の処理は未実装
#10000ふぁぼを超えることもありえるので、その時の処理を書く必要あり
#今のところ100ふぁぼより大きいとelseでコメント表示

  starYellow  = CE.fg(:yellow).get("★")
  starBlue    = CE.fg(:blue).get("★")
  starRed     = CE.fg(:red).get("★")

  favCount = favCount.to_i
  if favCount < 10
    puts starYellow * favCount
  elsif favCount >= 10 && favCount <= 100
    fav10 = favCount / 10
    fav10 = fav10.floor
    amari = favCount % 10   # 1の位のふぁぼ数を数える
    print starBlue * fav10
    print starYellow * amari
    print favCount
    puts 'fav'
  else
    puts 'fav over 100'
  end

end
