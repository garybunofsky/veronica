require 'sinatra/base'
require 'rubygems'
require 'json'
require 'twilio-ruby'
require 'sinatra'
require 'api-ai-ruby'

class Veronica < Sinatra::Base

	post '/' do
		
		# If inbound message is sent to Veronica.
		message = params[:Body]
		if message
			request_uri = 'https://newsapi.org/v1/articles?source=' + message.downcase + '&apiKey=c4dd56bf6afc4fa79401f2fd67bcc8e1'
			uri = URI(request_uri)
			response = Net::HTTP.get(uri)
			data = JSON.parse(response)
			
			# If NewsApi call was successful.
			status = data['status']
			if status == 'ok'
				article = data['articles']
				
				article.each do |item|
					@news = item['title']
					@url = item['url']
				end
				
				reply = @news + ' ' + @url
			else
				huh = ["I do not understand.", "I'm sorry, I don't follow you.", "I only know a few commands at the moment."]
				command_list = "Here's a list of commands: abc-news-au, ars-technica, associated-press, bbc-news, bbc-sport, bloomberg, business-insider, business-insider-uk, buzzfeed, cnbc, cnn, daily-mail, engadget, entertainment-weekly, espn, espn-cric-info, financial-times, football-italia, fortune, four-four-two, fox-sports, google-news, hacker-news, ign, independent, mashable, metro, mirror, mtv-news, mtv-news-uk, national-geographic, new-scientist, newsweek, new-york-magazine, nfl-news, polygon, recode, reddit-r-all, reuters, sky-news, sky-sports-news, talksport, techcrunch, techradar, the-economist, the-guardian-au, the-guardian-uk, the-hindu, the-huffington-post, the-lad-bible, the-new-york-times, the-next-web, the-sport-bible, the-telegraph, the-times-of-india, the-verge, the-wall-street-journal, the-washington-post, time, usa-today"
				reply = huh.sample + " " + command_list
			end
			sendText(reply)
		end
	end
	
	def sendText(reply)
		# Have Veronica send outbound message
		twiml = Twilio::TwiML::Response.new do |r|
			if reply
				r.Message reply
			end
		end
		twiml.text
	end

	get '/' do
		'Hi, my name is Veronica'
	end

	get '/voice' do
		content_type 'text/xml'
		"<Response><Say voice=\"alice\">Hello my name is Veronica.</Say><Pause length=\"1\"/><Say voice=\"alice\">I was built by Gary Bunofsky on March</Say></Response>"
	end

end
