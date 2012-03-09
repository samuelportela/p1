require 'spec_helper'

describe Auction do
  it { should validate_presence_of(:name).with_message('is mandatory') }
  
  it { should validate_presence_of(:product).with_message('is mandatory') }
  
  it 'should not validate last_bidder referential integrity when last_bidder_id is nil' do
    product = Product.new
    auction = Auction.new(:name => 'New iPod', :product => product, :last_bidder_id => nil)
    auction.should be_valid
  end
  
  it 'should validate last_bidder referential integrity when last_bidder_id is present' do
    product = Product.new
    auction = Auction.new(:name => 'New iPod', :product => product, :last_bidder_id => 1)
    auction.should_not be_valid
    auction.errors.size.should be 1
    auction.errors[:last_bidder].size.should be 1
    auction.errors[:last_bidder][0].should be_eql('not found')
  end
  
  it 'should be valid' do
    user = User.new(:email => 'user_email', :password => 'user_password', :role => :administrator)
    user.confirm!
    user.id.should_not be_nil
    product = Product.new
    auction = Auction.new(:name => 'New iPod', :product => product, :last_bidder_id => user.id)
    auction.should be_valid
  end
end
