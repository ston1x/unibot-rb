require "dotenv/load"
require "telegram/bot"
require "open-uri"
require "pry"
require "./parser"
include Parser

token = ENV["token"]
bot_username = ENV["rb_unibot"]
url = ENV["url"]
schedule = ""

puts "Token: #{token}"
puts "URL: #{url}"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/schedule"
      puts "/schedule"
      parse_schedule(url)

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: "This feature is currently under development"
      )
    when "/today"
      puts "/today"
      day = Date.today.strftime("%A").downcase
      if weekend?
        schedule = "Сегодня можно отдохнуть"
      else
        schedule = prepare_schedule(day)
      end

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )
    when "/monday"
      puts "/monday"
      schedule = prepare_schedule("monday")

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )

    when "/tuesday"
      puts "/tuesday"
      schedule = prepare_schedule("tuesday")

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )

    when "/wednesday"
      puts "/wednesday"
      schedule = prepare_schedule("wednesday")

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )

    when "/thursday"
      puts "/thursday"
      schedule = prepare_schedule("thursday")

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )

    when "/friday"
      puts "/friday"
      schedule = prepare_schedule("friday")

      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: "Markdown",
        text: schedule
      )
    end
  end
end

