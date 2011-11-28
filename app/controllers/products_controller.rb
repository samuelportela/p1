class ProductsController < ApplicationController
  def index
    @product = Product.new
    @products = Product.all
  end
  
  def create
    @product = Product.create params[:product]
    
    if @product.errors.empty?
      redirect_to :back, :notice => :successfully_saved
    else
      @products = Product.all
      render :action => :index
    end
  end
  
  def edit
    @product = Product.find params[:id]
  end
  
  def update
    @product = Product.find params[:id]
    
    if @product.update_attributes params[:product]
      redirect_to products_path, :notice => :successfully_saved
    else
      render :action => :edit
    end
  end
end
