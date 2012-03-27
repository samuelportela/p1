require 'spec_helper'

describe Bid do
  it { should validate_presence_of(:auction) }
  
  it { should validate_presence_of(:user) }
  
  it "should not be valid when the user has no remaining bids" do
    auction = Auction.new
    user = User.new(:remaining_bids => 0)
    bid = Bid.new(:auction => auction, :user => user)
    bid.should_not be_valid
  end
  
  it "should be valid" do
    mouse = Product.create(:name => 'magic mouse')
    auction = Auction.create(:name => 'apple mouse', :product => mouse)
    mouse.should be_valid
    auction.end_price.should == 0
    user = User.create(:email => 'valid@email.com',
      :password => 'user_password',
      :role => :bidder,
      :display_name => 'user_display_name',
      :remaining_bids => 1)
    bid = Bid.create(:auction => auction, :user => user)
    user = User.find(user.id)
    auction = Auction.find(auction.id)
    user.remaining_bids.should == 0
    auction.end_price.should == 0.01
  end
end
