class ProductsController < ApplicationController
  def index
    @product = Product.new
    @products = Product.all
  end
  
  def create
    Product.create params[:product]
    redirect_to :back
  end
  
  def edit
    @product = Product.find params[:id]
  end
  
  def update
    @product = Product.find params[:id]
    
    if @product.update_attributes params[:product]
      redirect_to products_path, :notice => t(:product_successfully_updated)
    else
      render :action => :edit
    end
  end
end
