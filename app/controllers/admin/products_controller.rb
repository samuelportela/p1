class Admin::ProductsController < Admin::AdminController
  load_and_authorize_resource
  respond_to :html
  
  def index
  end
  
  def show
  end
  
  def new
    5.times { @product.photos.build }
  end
  
  def create
    if @product.save
      flash[:notice] = t(:product_successfully_created)
    end
    respond_with(:admin, @product)
  end
  
  def edit
    5.times { @product.photos.build }
  end
  
  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = t(:product_successfully_updated)
    end
    respond_with(:admin, @product)
  end
  
  def destroy
    @product.destroy
    flash[:notice] = t(:product_successfully_removed)
    respond_with(:admin, @product)
  end
end
