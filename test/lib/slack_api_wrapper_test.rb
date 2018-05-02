require 'test_helper'

describe SlackApiWrapper do
  it "Can send valid message to real channel" do
    message = "test message"

    VCR.use_cassette("channels") do
    response = SlackApiWrapper.send_message("CAGCPB64A", message)
    response["ok"].must_equal true
    response["message"]["text"].must_equal message
  end
  end
end
