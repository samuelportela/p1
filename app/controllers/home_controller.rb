class HomeController < BaseController
  respond_to :html
  
  def index
    @auctions = Auction.where(:is_active => true)
    respond_with @auctions
  end
end
