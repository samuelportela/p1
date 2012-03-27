class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  belongs_to :last_bidder, :class_name => 'User', :foreign_key => 'last_bidder_id'
  
  after_initialize :init
  
  validates :name, :presence => true
  validates :product, :presence => true
  validates :end_price, :presence => true
  validates :last_bidder, :presence => {:message => :not_found}, :if => :has_last_bidder?
  
  def init
    if self.end_price.nil?
      self.end_price = 0
    end
  end
  
  def has_last_bidder?
    self.last_bidder_id.present?
  end
  
  def update_last_bidder(user)
    self.update_attribute(:last_bidder, user)
  end
  
  def increase_end_price
    self.update_attribute(:end_price, self.end_price + 0.01)
  end
end
