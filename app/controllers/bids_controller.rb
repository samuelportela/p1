class BidsController < BaseController
  load_and_authorize_resource
  respond_to :json
  
  def create
    @bid.auction_id = params[:auction_id]
    @bid.user = current_user
    
    if @bid.save
      notify_bid_creation
    end
    respond_with @bid
  end
  
  def notify_bid_creation
    begin
      RestClient.post "http://#{APP_CONFIG['node_js_host']}:#{APP_CONFIG['node_js_port']}/notifyBidCreation",
        :userId => @bid.user.id,
        :userDisplayName => @bid.user.display_name,
        :userBidsToDecrease => 1,
        :auctionId => @bid.auction.id,
        :auctionEndPrice => @bid.auction.end_price,
        :auctionRemainingTime => @bid.auction.remaining_time
    rescue
      puts 'An error occurred while trying to notify bid creation'
    end
  end
end
