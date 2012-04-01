class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.datetime :end_time
      t.decimal :end_price
      t.references :product
      t.integer :last_bidder_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
