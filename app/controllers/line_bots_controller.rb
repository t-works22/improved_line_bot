class LineBotsController < ApplicationController

  require 'line/bot'


  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      # クライアントからメッセージが送信された際
      when Line::Bot::Event::Message
        case event.type
        # クライアントからのメッセージがテキスト形式だった場合
        when Line::Bot::Event::MessageType::Text
          # event.message['text']でユーザーからのメッセージ内容を取得可能kanou
          input = event.message['text']
          case input
          when /.*(東京|とうきょう).*/

          end
          message = {
              type: 'text',
              text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    }
    "OK"
  end


  private

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET2"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN2"]
    }
  end
end