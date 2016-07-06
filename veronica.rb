require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

post '/reply' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message params[:Body]
	end
  twiml.text
end

get '/reply' do
end

# https://demo.twilio.com/welcome/sms/reply/
