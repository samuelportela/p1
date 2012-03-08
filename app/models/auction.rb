class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  belongs_to :last_bidder, :class_name => 'User', :foreign_key => 'last_bidder_id'
  
  validates :name, :presence => {:message => :is_mandatory}
  validates :product, :presence => {:message => :is_mandatory}
  validates :last_bidder, :presence => {:message => :not_found}, :if => 'last_bidder_id.present?'
end
