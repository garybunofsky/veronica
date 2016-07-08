require 'sinatra/base'
require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

class Veronica < Sinatra::Base

	post '/' do
	  twiml = Twilio::TwiML::Response.new do |r|
	    r.Message params[:Body]
		end
	  twiml.text
	end

	get '/' do
		'Hi my name is veronica.'
	end
end
