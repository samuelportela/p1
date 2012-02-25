class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  
  validates :auction, :presence => {:message => :is_mandatory}
  validates :user, :presence => {:message => :is_mandatory}
end
