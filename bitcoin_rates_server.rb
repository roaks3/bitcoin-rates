require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'firebase'
require 'sinatra/activerecord'

class BitcoinRateRequest < ActiveRecord::Base
end

set :database, {adapter: 'sqlite3', database: 'bitcoin_rates.db'}

get '/rates/bitcoin' do
  base_uri = 'https://publicdata-cryptocurrency.firebaseio.com'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.get('bitcoin')

  bitcoinRateRequest = BitcoinRateRequest.create(last: response.body['last'], ask: response.body['ask'], bid: response.body['bid'])

  {'rate' => {'last' => response.body['last'], 'ask' => response.body['ask'], 'bid' => response.body['bid']} }.to_json
end

