class HomeController < BaseController
  respond_to :html
  
  def index
    @auctions = Auction.all
    respond_with @auctions
  end
end
