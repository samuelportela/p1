class BidsController < BaseController
  load_and_authorize_resource
  respond_to :json
  
  def create
    @bid.auction_id = params[:auction_id]
    @bid.user = current_user
    
    @bid.save
    respond_with @bid
  end
end
