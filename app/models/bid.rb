class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  
  validates :auction, :presence => true
  validates :user, :presence => true
end
