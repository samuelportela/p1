class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  
  validates :auction, :presence => true
  validates :user, :presence => true
  validate :user_can_bid, :if => lambda { user.present? }
  
  after_save :update_auction_last_bidder
  after_save :update_auction_end_price
  after_save :update_user_remaining_bids
  
  def user_can_bid
    if !user.has_remaining_bids?
      self.errors.add(:user, :has_no_remaining_bids)
    end
  end
  
  def update_auction_last_bidder
    self.auction.update_last_bidder(user)
  end
  
  def update_auction_end_price
    self.auction.increase_end_price
  end
  
  def update_user_remaining_bids
    self.user.decrease_remaining_bids
  end
end
