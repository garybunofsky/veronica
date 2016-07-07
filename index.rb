require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

post '/' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message params[:Body]
	end
  twiml.text
end

get '/' do
	'veronica'
end

# https://demo.twilio.com/welcome/sms/reply/
