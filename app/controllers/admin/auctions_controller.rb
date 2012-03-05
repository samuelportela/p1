class Admin::AuctionsController < Admin::AdminController
  load_and_authorize_resource
  respond_to :html
  
  def index
  end
  
  def show
  end
  
  def new
  end
  
  def create
    if @auction.save
      flash[:notice] = t(:auction_successfully_created)
    end
    respond_with(:admin, @auction)
  end
  
  def edit
  end
  
  def update
    if @auction.update_attributes(params[:auction])
      flash[:notice] = t(:auction_successfully_updated)
    end
    respond_with(:admin, @auction)
  end
  
  def destroy
    @auction.destroy
    flash[:notice] = t(:auction_successfully_removed)
    respond_with(:admin, @auction)
  end
end
