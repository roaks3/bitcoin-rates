require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'firebase'

get '/rates/bitcoin' do
  base_uri = 'https://publicdata-cryptocurrency.firebaseio.com'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.get('bitcoin')

  {'rate' => {'last' => response.body['last'], 'ask' => response.body['ask'], 'bid' => response.body['bid']} }.to_json
end

