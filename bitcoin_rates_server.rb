require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'firebase'
require 'sinatra/activerecord'

class BitcoinRateRequest < ActiveRecord::Base
end

set :database, {adapter: 'sqlite3', database: 'bitcoin_rates.db'}

get '/rates/bitcoin' do
  begin
    base_uri = 'https://publicdata-cryptocurrency.firebaseio.com'

    firebase = Firebase::Client.new(base_uri)
    response = firebase.get('bitcoin')
  rescue => e
    logger.error(e)
    return 'Error retrieving the bitcoin rates from https://publicdata-cryptocurrency.firebaseio.com: ' + e.message
  end

  begin
    bitcoinRateRequest = BitcoinRateRequest.create(last: response.body['last'], ask: response.body['ask'], bid: response.body['bid'])
  rescue => e
    logger.error(e)
    return 'Error storing this request: ' + e.message
  end

  {'rate' => {'last' => bitcoinRateRequest.last, 'ask' => bitcoinRateRequest.ask, 'bid' => bitcoinRateRequest.bid} }.to_json
end

