require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "should display some products" do
      Product.create :name => 'magic mouse'
      
      visit products_path
      page.should have_content 'magic mouse'
    end
  end
end
