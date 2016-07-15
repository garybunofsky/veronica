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
				# See if Veronica understands the message
				reply = response[:result][:speech]
				if reply.empty?
					r.Message "Sorry, I don't understand."
				else
					r.Message reply
				end
			end
			twiml.text
		end

	end

	get '/' do
		'Hi, my name is Veronica'
	end

end
