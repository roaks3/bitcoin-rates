class CreateBitcoinRateRequests < ActiveRecord::Migration
  def change
    create_table :bitcoin_rate_requests do |t|
      t.decimal :last
      t.decimal :ask
      t.decimal :bid
      t.timestamps
    end
  end
end
