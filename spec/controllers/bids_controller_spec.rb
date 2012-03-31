require 'spec_helper'

describe BidsController do
  before do
    @bidder = User.create(:email => 'user_email',
      :password => 'user_password',
      :role => :bidder,
      :remaining_bids => 5)
    @bidder.confirm!
    sign_in @bidder
    @auction = Auction.create(:name => 'a1', :product => Product.new)
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, :auction_id => @auction.id, :format => 'json'
      response.should be_success
    end
  end

end
