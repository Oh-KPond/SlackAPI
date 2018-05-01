require 'httparty'

class SlackApiWrapper
  URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    response = HTTParty.get("#{URL}channels.list?token=#{TOKEN}")

    channel_list = []

    if response["channels"]
      response["channels"].each do |channel|
        channel_list << Channel.new(channel["name"], channel["id"])
      end
    end
    return channel_list
  end

  def self.send_message(channel, message)
    message_url = "#{URL}chat.postMessage"
    response = HTTParty.post(message_url,
      body: {
        "token" => TOKEN,
        "channel" => channel,
        "text" => message,
        "username" => "The Unicorn Bot",
        "icon_url" => "http://www.sitetrail.com/wp-content/uploads/2017/04/unicorn.png",
      },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}
    )
    return response.success?

  end
end
