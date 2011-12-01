class ProductsController < ApplicationController
  respond_to :html
  
  def index
    @products = Product.all
    respond_with @products
  end
  
  def show
    @product = Product.find(params[:id])
    respond_with @product
  end
  
  def new
    @product = Product.new
    respond_with @product
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = :product_successfully_created
    end
    respond_with @product
  end
  
  def edit
    @product = Product.find(params[:id])
    respond_with @product
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = :product_successfully_updated
    end
    respond_with @product
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = :product_successfully_removed
    respond_with @product
  end
end
