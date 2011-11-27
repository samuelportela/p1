require 'spec_helper'

describe 'Products' do
  before do
    @product = Product.create :name => 'magic mouse'
  end
  
  describe 'GET /products' do
    it 'should display some products' do
      visit products_path
      page.should have_content 'magic mouse'
    end
    
    it 'should create a new product' do
      visit products_path
      
      fill_in :name, :with => 'trust mouse'
      click_button 'Create Product'
      
      current_path.should == products_path
      page.should have_content 'trust mouse'
    end
  end
  
  describe 'PUT /products' do
    it 'should edit a product' do
      visit products_path
      click_link 'Edit'
      
      current_path.should == edit_product_path(@product)
      find_field('Name').value.should == 'magic mouse'
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Update Product'
      
      current_path.should == products_path
      page.should have_content 'successfully updated'
      page.should have_content 'trust mouse'
    end
    
    it 'should not update an empty name' do
      visit products_path
      click_link 'Edit'
      fill_in 'Name', :with => ''
      click_button 'Update Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
end
