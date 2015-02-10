#ruby

require 'bundler/setup'
require 'json'
require 'net/http'
require 'sinatra'
require_relative 'time_to_next'

SLACK_TOKEN=ENV['SLACK_TOKEN']
TRIGGER_WORD="meetup?"

post "/gif" do
  return 401 unless request["token"] == SLACK_TOKEN
  q = request["text"]
  return 200 unless q.start_with? TRIGGER_WORD
  q = q[TRIGGER_WORD.size..-1]
  text = get_time(q)
  reply = {username: "RubyNewbiesBot", icon_emoji: ":mega:", text: text}
  return JSON.generate(reply)
end
