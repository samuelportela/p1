require 'spec_helper'

describe 'Products' do
  before do
    @product = Product.create :name => 'magic mouse'
  end
  
  describe 'GET index' do
    it 'should list some products' do
      visit products_path
      page.should have_content 'magic mouse'
    end
  end
  
  describe 'POST create' do
    it 'should create a product' do
      visit products_path
      click_link 'New'
      
      current_path.should == new_product_path
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Create Product'
      
      page.should have_content 'Product successfully created.'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      click_link 'New'
      
      current_path.should == new_product_path
      
      click_button 'Create Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'PUT update' do
    it 'should update a product' do
      visit products_path
      click_link 'Edit'
      
      current_path.should == edit_product_path(@product)
      find_field('Name').value.should == 'magic mouse'
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Update Product'
      
      current_path.should == product_path(@product)
      page.should have_content 'Product successfully updated.'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      click_link 'Edit'
      
      current_path.should == edit_product_path(@product)
      
      fill_in 'Name', :with => ''
      click_button 'Update Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
end
