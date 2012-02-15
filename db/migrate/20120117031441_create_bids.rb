class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.datetime :time
      t.references :auction
      t.references :user

      t.timestamps
    end
  end
end
