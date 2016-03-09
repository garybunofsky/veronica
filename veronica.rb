require 'sinatra'
require 'twilio-ruby'

post '/receive' do
	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
		r.Message 'Hello, I am Veronica. What is your name?'
	end

	response.to_xml
end

post '/send' do
	to = params["to"]
	message = params["body"]
	client = Twilio::REST::Client.new(
		ENV['TWILIO_ACCOUNT_SID'],
		ENV['TWILIO_AUTH_TOKEN']
	)

	client.messages.create(
		to: to,
		from: "+12162424157",
		body: message
	)
end

get '/' do
  'Hello world!'
end
