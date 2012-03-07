class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :finish_at
      t.decimal :end_price
      t.references :product
      t.integer :last_bidder_id

      t.timestamps
    end
  end
end
