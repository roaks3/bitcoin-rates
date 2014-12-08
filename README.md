bitcoin-rates
=============

This is a simple REST server that can be used to query the current bitcoin exchange rates. On the backend, it logs all requests into a SQLite database.

##Setup

To set up the REST server, first create the database to be used for logging requests:

    bundle exec rake db:migrate

Then, start the REST server:

    ruby bitcoin_rates_server.rb

##Usage

This REST server comes with two endpoints:

    GET /rates/bitcoin - get the current bitcoin exchange rates
    GET /requests/bitcoin - get all of the requests made to the rates endpoint; offset and limit parameters can be used to page through results

