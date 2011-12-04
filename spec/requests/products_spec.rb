require 'spec_helper'

describe 'Products' do
  before do
    @mouse = Product.create(:name => 'magic mouse')
    @keyboard = Product.create(:name => 'hot keyboard')
  end
  
  describe 'GET index' do
    it 'should list some products' do
      visit products_path
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
    end
  end
  
  describe 'POST create' do
    it 'should create a product' do
      visit products_path
      click_link 'Create'
      
      current_path.should == new_product_path
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Create Product'
      
      page.should have_content 'Product successfully created.'
      page.should have_content 'trust mouse'
      
      click_link 'List'
      
      current_path.should == products_path
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      click_link 'Create'
      
      current_path.should == new_product_path
      
      click_button 'Create Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'PUT update' do
    it 'should update a product' do
      visit products_path
      find("#product_#{@mouse.id}").click_link 'Edit'
      
      current_path.should == edit_product_path(@mouse)
      find_field('Name').value.should == 'magic mouse'
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Update Product'
      
      current_path.should == product_path(@mouse)
      page.should have_content 'Product successfully updated.'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      find("#product_#{@keyboard.id}").click_link 'Edit'
      
      current_path.should == edit_product_path(@keyboard)
      find_field('Name').value.should == 'hot keyboard'
      
      fill_in 'Name', :with => ''
      click_button 'Update Product'
      
      current_path.should == product_path(@keyboard)
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'DELETE destroy' do
    it 'should delete a product' do
      visit products_path
      
      confirm_message = 'Are you sure you want to remove this product?'
      list_item = find("#product_#{@mouse.id}")
      hyperlink = list_item.find("a[@data-confirm='#{confirm_message}']")
      hyperlink.text.should == 'Remove'
      list_item.click_link 'Remove'
      
      current_path.should == products_path
      page.should have_content 'Product successfully removed'
      page.should_not have_content 'magic mouse'
      page.should have_content 'hot keyboard'
    end
  end
end
