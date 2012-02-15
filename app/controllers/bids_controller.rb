class BidsController < ApplicationController
  load_and_authorize_resource
  respond_to :html
  
  def index
  end
  
  def show
  end
  
  def new
  end
  
  def create
    if @bid.save
      flash[:notice] = t(:bid_successfully_created)
    end
    respond_with @bid
  end
  
  def edit
  end
  
  def update
    if @bid.update_attributes(params[:bid])
      flash[:notice] = t(:bid_successfully_updated)
    end
    respond_with @bid
  end
  
  def destroy
    @bid.destroy
    flash[:notice] = t(:bid_successfully_removed)
    respond_with @bid
  end
end
