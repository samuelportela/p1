class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  belongs_to :last_bidder, :class_name => 'User', :foreign_key => 'last_bidder_id'
  
  validates :name, :presence => true
  validates :product, :presence => true
  validates :last_bidder, :presence => {:message => :not_found}, :if => :has_last_bidder?
  
  def has_last_bidder?
    self.last_bidder_id.present?
  end
  
  def update_last_bidder(user)
    self.update_attribute(:last_bidder, user)
  end
  
  def increase_end_price
    self.end_price += 0.01
  end
end
