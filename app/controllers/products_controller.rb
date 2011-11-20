class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  
  def create
    Product.create params[:product]
    redirect_to :back
  end

end
