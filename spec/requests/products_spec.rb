require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "should display some products" do
      Product.create :name => 'magic mouse'
      
      visit products_path
      page.should have_content 'magic mouse'
    end
    
    it "should create a new product" do
      visit products_path
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Create Product'
      
      page.should have_content 'trust mouse'
      save_and_open_page
    end
  end
end
