require 'sinatra'
require 'twilio-ruby'

use Rack::TwilioWebhookAuthentication, ENV['AUTH_TOKEN'], '/message/forward'


post '/message/forward/?' do
	# take the forward number from the URL parameter 
	# and the content of the message from the POST param
	# we then concatenate a message telling who the SMS is from
	
	forward_number = params[:to]
	body = "Message from #{params[:From]}: #{params[:Body]}"

	#create a Twiml Response object
	response = Twilio::TwiML::Response.new do |r|
		r.Message body, to: forward_number
	end
	response.text

end