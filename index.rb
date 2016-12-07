require 'sinatra/base'
require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'api-ai-ruby'
class Veronica < Sinatra::Base

	post '/' do
		# Establish connection with api.ai
		client = ApiAiRuby::Client.new(
				:client_access_token => 'e1d0afd773944e738d57d44658e543aa',
		)

		# If inbound message is sent to Veronica
		message = params[:Body]
		if message
			response = client.text_request message
			twiml = Twilio::TwiML::Response.new do |r|
				reply = response[:result][:fulfillment][:speech]
				if reply
					r.Message reply
				end
			end
			twiml.text
		end
	end

	get '/' do
		'Hi, my name is Veronica'
	end

	get '/voice' do
		content_type 'text/xml'
		"<Response><Say voice=\"alice\">Hello my name is Veronica.</Say><Pause length=\"1\"/><Say voice=\"alice\">I was built by Gary Bunofsky on March</Say></Response>"
	end

 end
