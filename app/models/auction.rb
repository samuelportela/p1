class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  belongs_to :last_bidder, :class_name => 'User', :foreign_key => 'last_bidder_id'
  
  validates :name, :presence => true
  validates :product, :presence => true
  validates :last_bidder, :presence => {:message => :not_found}, :if => :has_last_bidder?
  
  def has_last_bidder?
    last_bidder_id.present?
  end
end
