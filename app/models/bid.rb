class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  
  validates :auction, :presence => true
  validates :user, :presence => true
  
  after_save :update_auction_last_bidder
  
  def update_auction_last_bidder
    auction.update_last_bidder(user)
  end
end
