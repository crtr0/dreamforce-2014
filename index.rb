require 'sinatra'
require 'twilio-ruby'

get '/sms' do
  response = Twilio::TwiML::Response.new do |r|
    r.Message do |m|
      m.Body "What happens you put the power of the telecommunications industry in the hands of web developers?"
      m.Media 'http://linode.rabasa.com/mindblown.gif'
    end
  end
  content_type 'text/xml'
  response.text
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APc11a96ef976afd91cd58ca11a9daf118'
  capability.generate
end

get '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  nums = client.messages.list(to:'+13059648570').collect{|m| m.from}
  random = '+12022856865' # nums.sample
  response = Twilio::TwiML::Response.new do |r|
    r.Dial callerId: '+13059648570' do |d|
      d.Number random
    end
  end
  content_type 'text/xml'
  response.text  
end
