class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  
  validates :name, :presence => {:message => :is_mandatory}
  validates :product, :presence => {:message => :is_mandatory}
end
