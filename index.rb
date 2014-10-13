require 'sinatra'
require 'twilio-ruby'

get '/message' do 
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message do |m|
      m.Body "What happens when you put the power of telecommunications in the hands of developers?"
      m.Media "/img/mindblown.gif"
    end
  end
  content_type 'text/xml'
  twiml.text
end

get '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  nums = client.messages.list(to: '+12027598424').collect{|m| m.from}.uniq
  num = nums.sample
  twiml = Twilio::TwiML::Response.new do |r|
    r.Dial callerId: '+12027598424' do |d|
      d.Number num
    end
  end
  content_type 'text/xml'
  twiml.text  
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APc8bd72e65533ce7dc6f90856396bdf50'
  capability.generate
end